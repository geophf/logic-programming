/*
Okay, we want to POST JSON to a REST endpoint then receive back JSON
as a result. Let's POST to the REST endpoint of a graph database.

The arguments to this program are:

<endpoint URL> username password 

compile this program with:

$ swipl -o qit -c things/04_REST_endpoint.pl
*/

:- ['utils/list'].

:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).

:- json_object cypher(statements:list).
:- json_object query(statement:string).

:- initialization(main, main).

:- ['utils/json'].
:- ['utils/avl'].
:- ['utils/neo4j'].

main(_) :-
   graph_connect_info(User, Pass, URL),
   transaction(URL, Endpoint),
   Query = "MATCH (n) RETURN n LIMIT 5",
   prolog_to_json(cypher([query(Query)]), JSON),
   json_it(Endpoint, JSON, User, Pass).

json_it(Endpoint, JSON, User, Pass) :-
   http_post(Endpoint, json(JSON), Atom, [authorization(basic(User, Pass))]),
   name(Atom, Str),
   json(object(Obj), Str, []),
   avl_get(Obj, results, array([object(Res)])),
   avl_get(Res, data, array(Rows)), % rows are composed of row and meta
   do(process_row, Rows), nl,
   avl_get(Obj, errors, array(Errs)),
   write('Errors were '), print(Errs), nl.

process_row(object(Row)) :-
   avl_get(Row, row, array([Item])),
   DepthXform = xform(depth, number(X), depth(X)),
   translate(name-name, NameXform),
   json_to_term(topic, [NameXform, DepthXform], Item, Topic),
   print(Topic), nl.
process_row(object(Row)) :-
   write('I dunno '), print(Row), nl.

/*
$ ./qit <neo4j transaction url> <user> <pass>

I dunno t(row,array([object(t)]),
              t(meta,array([object(t(id,number(0),t(deleted,false,t,t,1),
                                   t(type,string(node),t,t,1),2))]),t,t,1),t,2)
topic(name(sports),depth(1))
topic(name(college),depth(2))
topic(name('old-dominion'),depth(3))
topic(name(football),depth(4))

BOOM!

Now, ... SOME of this functionality (like converting to JSON-"statements", 
transacting the endpoint, and decoding down to the row-data and meta data) 
... MIGHT be uSEfUl as a neo4j library. We shall see.
*/
