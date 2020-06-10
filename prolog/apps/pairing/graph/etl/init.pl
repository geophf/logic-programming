% initializes the graph database with the seed data: names and pairings

:- ['utils/str'].
:- ['utils/list'].

:- ['utils/neo4j'].

:- ['apps/pairing/graph/etl/seed'].
:- ['apps/pairing/graph/etl/uploader'].

init_db :-
   findall(Name, (member(M), capitalize_atom2str(M, Name)), Names),
   upload_names(Names),
   init_top,
   do(uploader, [week1, week2, week3]),
   write('Graph data store initialized.'), nl, nl, write('... have fun!'), nl.

uploader(Fn) :-
   Pairings =.. [Fn, Date, Week],
   Pairings,
   upload_pairings(Date, Week, Meetn),
   link_pairings(Meetn).
