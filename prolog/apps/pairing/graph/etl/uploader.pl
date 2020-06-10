:- ['utils/list'].
:- ['utils/neo4j'].
:- ['utils/cypher'].
:- ['utils/str'].

:- ['apps/pairing/graph/admin'].

% loads the teams to our graph store

upload_names(Names) :-
   map1(tt_cn, Names, Cyph0, []),
   map1(id, ["MATCH (m) SET m:ACTIVE"], Cyphs, Cyph0),
   data_store(DB),
   store_graph(DB, Cyphs).

tt_cn(Name, Cyph) :-
   atom_string(N, Name),
   create_node(jigsawyer(name(N)), Cyph).

/*
We need to upload these data to the graph store, I'm thinking

(a)-[:PAIRED on: date]->(b) ...

then have

(:LastPairings)-[:FOLLOWS]->(:Pairings date: date)-[:FOLLOWS]->(:Pairings ...)

And pull the :PAIRED for the dates on the last n pairings.
*/

/*
So, FRIST!

GIVEN: we've [somehow] [magically] created the pairs and triples for today,
Let's add to our pairs-sets, uploading the pairs for today.

SO, FRIST!

We want to get the 'LastPairings' and the link to its date, then link today's
pairings to last pairings (deleting that old link), and pointing today's
pairings as last pairings.

We ASSUME that today's pairings is alreadly linked with its pairs.
*/

link_pairings(PairingsNode) :-
   data_store(DB),
   query_graph_store(DB,
                    ["MATCH (:Top)-[a:AT]->(p:Pairings) DELETE a RETURN p"],
                    LastPairing),
   merge_relation(at, top - PairingsNode, Stmt),
   relink(PairingsNode, LastPairing, Stmts),
   store_graph(DB, [Stmt|Stmts]).

relink(_, no_results(_), []).
relink(Pairings, results(data([P]), _, _), [Merge]) :-
   extract(date, P, DAtom),
   atom_string(DAtom, PrevDate),
   P1 = pairings(date(PrevDate)),
   merge_relation(following, Pairings - P1, Merge).

/*
Okay, now that we've got that working ... assuming x, y, and z, let's create
the pairings as a thing and link all out pairs in a link-friendly way.

The structure is (joe)-[:PAIRED on: date]->(beatta) or
(fran)-[:TRIPLED on: date]->(ed)-[:TRIPLED on: date]->(xavier)

(so the membership test shall be different than what is declared below)

... then all of the members, above, are linked to the (Pairings date: date) node

Format for pairings are:

paired(date('June 4, 2020'),ken,shoaib).

triple(date('June 4, 2020'),[doug,jose,apoorv]).
*/

upload_pairings(Date, Pairings, Mtg) :-
   data_store(DB),
   Mtg = pairings(date(Date)),
   create_node(Mtg, Stmt),
   map(upload_pairing(Mtg), Pairings, Rels),
   flatten(Rels, Stmts),
   store_graph(DB, [Stmt|Stmts]).

upload_pairing(Mtg, paired(date(Date), A, B), [S0|Stmts]) :-
   map(capitalize_atom2str, [A, B], Caps),
   map(namei, Caps, [Na, Nb]),
   merge_relation(paired(on(Date)), Na - Nb, S0),
   map(merge_relation(attended), [Na - Mtg, Nb - Mtg], Stmts).

upload_pairing(Mtg, triple(date(Date), Trips), Stmts) :-
   map(capitalize_atom2str, Trips, Caps),
   map(namei, Caps, [Na, Nb, Nc]),
   map1(merge_relation(tripled(on(Date))), [Na - Nb, Nb - Nc, Nc - Na], Ss, []),
   map1(merge_relation(attended), [Na - Mtg, Nb - Mtg, Nc - Mtg], Stmts, Ss).

namei(Person, jigsawyer(name(Person))).

% and we need the pairings to be pointed at by SOMEthing! :<

init_top :-
   data_store(DB),
   create_node(top, T),
   store_graph(DB, [T]).
