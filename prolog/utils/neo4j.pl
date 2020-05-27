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

upload_to_graph_store(Cyphers, Response) :-
   graph_connect_info(User, Pass, URL),
   transaction(URL, Endpoint),
   upload_to_graph_store1(Cyphers, User, Pass, Endpoint, Response).

upload_to_graph_store1(Cyphers, User, Pass, Endpoint,
                       result_set(Rows, Metadata, Errors)) :-
   map(tag(query), Cyphers, Stmts),
   prolog_to_json(cypher(Stmts), JSON),
   http_post(Endpoint, json(JSON), Atom,
             [authorization(basic(User, Pass))]),
   rows_metadata_errors(Atom, Rows, Metadata, Errors).

rows_metadata_errors(Atom, Rows, Metadata, Errors) :-
   name(Atom, Str),
   json(object(Obj), Str, []),
   avl_get(Obj, errors, array(Errs)),
   avl_get(Obj, results, array([object(Res)])),
   avl_get(Res, data, array(Rows)), % rows are composed of row and meta

