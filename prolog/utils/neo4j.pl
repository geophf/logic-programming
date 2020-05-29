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

% stolen from things/05_environment

graph_connect_info(User, Pass, Endpoint) :-
   getenv('PROLOG_GRAPH_USER', User),
   getenv('PROLOG_GRAPH_PASS', Pass),
   getenv('PROLOG_GRAPH_ENDPOINT', Endpoint).

% generalized from things/04_REST_endpoint

transaction(URL, Xact) :-
   atom_string(URL, DB),

   % we assume the URL is terminated with a /, or else everything breaks.
   string_concat(DB, "transaction/commit", BD),
   atom_string(Xact, BD).

store_graph(Cyphers) :-
   graph_connect_info(User, Pass, URL),
   transaction(URL, Endpoint),
   store_graph1(Cyphers, User, Pass, Endpoint, _).

tag(Fn, Val, Tag) :-
   Tag =.. [Fn, Val].

store_graph1(Cyphers, User, Pass, Endpoint, Response) :-
   map(tag(query), Cyphers, Stmts),
   prolog_to_json(cypher(Stmts), JSON),
   http_post(Endpoint, json(JSON), Response,
             [authorization(basic(User, Pass))]).

query_graph_store(Cyphers, Response) :-
   graph_connect_info(User, Pass, URL),
   transaction(URL, Endpoint),
   query_graph_store1(Cyphers, User, Pass, Endpoint, Response).

query_graph_store1(Cyphers, User, Pass, Endpoint,
                       result_set(Rows, Metadata, Errors)) :-
   store_graph1(Cyphers, User, Pass, Endpoint, JSON),
   rows_metadata_errors(JSON, Rows, Metadata, Errors).

rows_metadata_errors(json(JSON), data(Rows), metadata(Metadata), errors(Errors)) :-
   [results = [Results], errors = Errors] = JSON,
   extract(data, Results, Data),
   unzip_with(row_meta, Data, Rows, Metadata).

extract(Key, json(Row), Value) :-
   extract1(Key, Row, Value).

extract1(Key, [Key=Value|_], Value).
extract1(Key, [K1=_|T], Value) :-
   not(Key = K1),
   extract1(Key, T, Value).

row_meta(json(Result), Row, meta(Meta)) :-
   [row = [json(Row)], meta = [json(Meta)]] = Result.
row_meta(json(Result), Row, Metas) :-
   [row = [JSONS], meta = [MList]] = Result,
   relate(JSONS, Row),
   map(dejson, MList, M0),
   map(tag(meta), M0, Metas).

dejson(json(Term), Term).
relate(Row, A-B) :-
   map(dejson, Row, [A, _, B]).
