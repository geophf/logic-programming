% initializes the graph database with the seed data: names and pairings

:- ['utils/str'].
:- ['utils/list'].

:- ['utils/neo4j'].

:- ['apps/pairing/graph/etl/seed'].
:- ['apps/pairing/graph/etl/uploader'].

init_db :-
   init_top,
   findall(Name, (member(M), capitalize_atom2str(M, Name)), Names),
   upload_names(Names),
   findall(Namu, (ex_member(N), capitalize_atom2str(N, Namu)), Unnames),
   deactivate(Unnames),
   findall(week(Date, Pairings), week(_Idx, Date, Pairings), PairingsInfo),
   do(uploader, PairingsInfo),
   write('Graph data store initialized.'), nl, nl, write('... have fun!'), nl.

uploader(week(Date,Pairings)) :-
   write('uploading pairings for '), write(Date), nl,
   upload_pairings(Date, Pairings, Meetn),
   link_pairings(Meetn).
