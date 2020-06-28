/*
Routines to connect to, upload to, and download from neo4j graph store.
*/

:- ['utils/list'].

:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
   
:- json_object cypher(statements:list).
:- json_object query(statement:string).

:- ['utils/json'].
:- ['utils/avl'].
:- ['utils/cypher'].
:- ['utils/graph'].

% ------------------------------------------------------- UPLOADING -----

% for when you're feeling salty! ;)

clear_graph(DB) :-
   store_graph(DB, ["MATCH (n) DETACH DELETE n"]).

store_graph(Database, Cyphers) :-
   store_graph_helper(Database, Cyphers, _).

store_graph_helper(Database, Cyphers, Response) :-
   graph_connect_info(Database, User, Pass, URL),
   transaction(URL, Endpoint),
   store_graph1(Cyphers, User, Pass, Endpoint, Response).

store_graph1(Cyphers, User, Pass, Endpoint, Response) :-
   map(tag(query), Cyphers, Stmts),
   prolog_to_json(cypher(Stmts), JSON),
   http_post(Endpoint, json(JSON), Response,
             [authorization(basic(User, Pass))]).

% stolen from things/05_environment

graph_connect_info(Database, User, Pass, Endpoint) :-
   atom_string(Database, DB),
   string_concat(DB, "_USER", UStr),
   string_concat(DB, "_PASS", PStr),
   string_concat(DB, "_ENDPOINT", EStr),
   atom_string(U, UStr),
   atom_string(P, PStr),
   atom_string(E, EStr),
   getenv(U, User),
   getenv(P, Pass),
   getenv(E, Endpoint).

tag(Fn, Val, Tag) :-
   Tag =.. [Fn, Val].

% generalized from things/04_REST_endpoint

transaction(URL, Xact) :-
   atom_string(URL, DB),

   % we assume the URL is terminated with a /, or else everything breaks.

   string_concat(DB, "transaction/commit", BD),
   atom_string(Xact, BD).

/* ------------------------------------------------------- downloading --- */

% Okay, so we've uploaded the graph. Now, let's download it:

extract_label([label = Label], Label).

vertices(Vertices) :-
   query_graph_store(["MATCH (n) RETURN n"], Response),
   Response = result_set(data(Rows), _, _),
   map(extract_label, Rows, Vertices).

/*
?- vertices(Vertices).
Vertices = [b, c, d, f, g, h, k] .
*/

extract_rel(A - B, C - D) :-
   map(extract_label, [A, B], [C, D]).

relations(Edges) :-
   query_graph_store(["MATCH path=()-[]->() RETURN path"], Response),
   Response = result_set(data(Rows), _, _),
   map(extract_rel, Rows, Edges).

/*
?- relations(Edges).
Edges = [b-c, f-c, f-b, h-g, k-f] .
*/

% Therefore:

graph(graph(Nodes, Edges)) :-
   vertices(Nodes),
   relations(Es),
   map(relabel_edge(e), Es, Edges).

/*
?- graph(G).
G = graph([b,c,d,f,g,h,k], [e(b,c), e(f,c), e(f,b), e(h,g), e(k,f)]) .
*/

query_graph_store(Database, Cyphers, Response) :-
   graph_connect_info(Database, User, Pass, URL),
   transaction(URL, Endpoint),
   query_graph_store1(Cyphers, User, Pass, Endpoint, Response).

query_graph_store1(Cyphers, User, Pass, Endpoint, Results) :-
   store_graph1(Cyphers, User, Pass, Endpoint, JSON),
   rows_metadata_errors(JSON, Results).

rows_metadata_errors(JSON, Results) :-
   extract(results, JSON, Rows),
   extract(errors, JSON, Errors),
   map(extract(data), Rows, Datas),
   flatten(Datas, Data),
   process_results(Data, Errors, Results).

process_results([], Err, no_results(errors(Err))).
process_results([H|T], Err, results(data(Rows), metadata(MD), errors(Err))) :-
   unzip_with(row_meta, [H|T], Rows, MD).

extract(Key, json(Row), Value) :-
   extract1(Key, Row, Value).

extract1(Key, [Key=Value|_], Value).
extract1(Key, [K1=_|T], Value) :-
   not(Key = K1),
   extract1(Key, T, Value).

row_meta(Result, RowR, Metas) :-
   extract(row, Result, [Rows]),
   (extract(meta, Result, [M0]) ->    % necessary for older versions of database
      Meta = meta(M0)                 % that do not return metadata.
   ;
      Meta = no_meta),
   row_meta1(Rows, Meta, RowR, Metas).     % You can't kill the meta1

% For a relation result

row_meta1(Rows, Meta, RowR, Metas) :-  
   relate(Rows, RowR),
   map(dejson, Meta, M0),
   map(tag(meta), M0, Metas).

% For other results

row_meta1(Rows, Meta, Rows, Meta).

dejson(json(Term), Term).
relate(Row, A-B) :-
   map(dejson, Row, [A, _, B]).
