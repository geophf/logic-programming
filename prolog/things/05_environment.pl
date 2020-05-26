/*
Besides from the command-line we ... maybe? ... need to read from the 
environment?

We can certainly pass in the environment on the command-line as context. That's
one way of going about it, and certainly cloud-y in the AWS-sense, but there
also will be cases where we store stuff (like: the database connection-string)
in the environment that we need to snarf before we proceed.

Get that environment: just get it!
*/

:- initialization(main, main).

:- ['utils/list'].
:- ['utils/io'].

main(_) :-
   write('Connection arguments to our Prolog Graph data store:'), nl, nl,
   graph_connect_info(User, Pass, Endpoint),
   zip(['PROLOG_GRAPH_USER','PROLOG_GRAPH_PASS','PROLOG_GRAPH_ENDPOINT'],
       [User, Pass, Endpoint], Infos),
   do(write_term, Infos).
   
graph_connect_info(User, Pass, Endpoint) :-
   getenv('PROLOG_GRAPH_USER', User),
   getenv('PROLOG_GRAPH_PASS', Pass),
   getenv('PROLOG_GRAPH_ENDPOINT', Endpoint).

/*
$ ./envs yo                     
Connection arguments to our Prolog Graph data store:

'PROLOG_GRAPH_USER'-sumthin
'PROLOG_GRAPH_PASS'-sumthin_else
'PROLOG_GRAPH_ENDPOINT'-sumwherez
*/
