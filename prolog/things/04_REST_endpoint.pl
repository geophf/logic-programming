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

main([URL, User, Pass]) :-
   % transaction(URL, Endpoint),
   Endpoint = URL,
   Query = "MATCH (n) RETURN n LIMIT 5",
   % prolog_to_json(query(Query), Qur),
   % write('Query is '), print(Qur), nl,
   prolog_to_json(cypher([query(Query)]), JSON),
   % write('JSON it '), print(JSON), nl,
   json_it(Endpoint, JSON, User, Pass).

main(_) :-
   write('You must call this with the URL, the username, and password to the REST endpoint.'),
   nl.

json_it(Endpoint, JSON, User, Pass) :-
   http_post(Endpoint, json(JSON), Atom, [authorization(basic(User, Pass))]),
   % write('Results '), print(Atom), nl, % we get back an atom
   name(Atom, Str),
   json(object(Obj), Str, []),
   % write('Tree is '), print(Obj), nl,
   avl_get(Obj, results, array([object(Res)])),
   % write('Res is '), print(Res), nl,
   avl_get(Res, data, array(Rows)), % rows are composed of row and meta
   % write('Rows is '), print(Rows), nl,
   do(process_row, Rows).

/*
   Results = json([results=[json([columns=_Col,data=Data])], errors=Errs]),
   write('I got:'), nl, nl,
   do(process_datum, Data), nl, nl,
   write('Errors were: '), write(Errs), nl.
 */

transaction(URL, Xact) :-
   name(URL, DB),
   append(DB, "/transaction/commit", BD),
   name(Xact, BD).

process_datum(json([row=[Json], meta=_])) :-
   print(Json), nl.
process_datum(Huh) :-
   write('... and I got this??? '), print(Huh), nl.

process_row(object(Row)) :-
   avl_get(Row, row, array([Item])),
   % write('I got item '), print(Item), nl,
   DepthXform = xform(depth, number(X), depth(X)),
   translate(name-name, NameXform),
   % write(translated-name), print(NameXform), nl,
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
*/
