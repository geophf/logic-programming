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

/*
To refresh the entire database (clear it and reupload all historical pairings):

?- init_db.

To upload this week's pairings only (say: this week is August 13, 2020):

?- D = 'August 13, 2020',
   week(_, D, L),
   uploader(week(D, L)).

To verify the pairings are in neo4j:

MATCH (p)-[:PAIRED { on: 'August 13, 2020'}]->(q) 
RETURN  p.name,q.name
*/
