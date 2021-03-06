/*
Problem: we need to pair of devs, but not pair them with their previous sets
of pairings (then we need to age-out pairings, too

Solution: voila!
*/

:- ['utils/list'].
:- ['utils/neo4j'].
:- ['utils/cypher'].
:- ['utils/str'].

data_store('TEAM_PAIRING').

% selects only the active members of Jigsaw

jigsawyers(Members) :-
   data_store(DB),
   query_graph_store(DB, ["MATCH (p:Jigsawyer:ACTIVE) RETURN p"], Response),
   Response = results(data(Rows), _, _),
   map(extract(name), Rows, Members).

% NamesStr is the names you want to add, e.g.: "Bob Joe Fred" ...

% upload_names("Len Howie Ray Nicole Morgan Jose Tony Apoorv Ken Doug Shoaib").

upload_names(NamesStr) :-
   words(NamesStr, Names),
   map(tt_cn, Names, Cyphs),
   data_store(DB),
   store_graph(DB, Cyphs).

tt_cn(Name, Cyph) :-
   atom_string(N, Name),
   create_node(jigsawyer(name(N)), Cyph).

/*
member(len).
member(howie).
member(ray).
member(nicole).
member(morgan).
member(jose).
member(tony).
member(apoorv).
member(ken).
member(doug).
member(shoaib).
*/

% week 1: may 21

week1(List) :-
   % paired(date('May 21, 2020'), len, howie).   /* triple */
   % paired(date('May 21, 2020'), howie, tony).  /* triple */
   List = [paired(date('May 21, 2020'), ray, nicole),
           paired(date('May 21, 2020'), morgan, jose),
           paired(date('May 21, 2020'), shoaib, apoorv),
           paired(date('May 21, 2020'), ken, doug),
           triple(date('May 21, 2020'), [len, howie, tony])].

% week 2: may 28

week2(List) :-
   % paired(date('May 28, 2020'), ray, shoaib).   /* triple */
   % paired(date('May 28, 2020'), shoaib, doug).  /* triple */
   List = [paired(date('May 28, 2020'), len, apoorv),
           paired(date('May 28, 2020'), morgan, nicole),
           paired(date('May 28, 2020'), howie, jose),
           paired(date('May 28, 2020'), ken, tony),
           triple(date('May 28, 2020'), [ray, shoaib, doug])].

% week 3: jun 04

week3(List) :-
   % paired(date('June 4, 2020'),jose,apoorv).    /* triple */
   List = [paired(date('June 4, 2020'),len,ray),
           paired(date('June 4, 2020'),howie,nicole),
           paired(date('June 4, 2020'),morgan,tony),
           paired(date('June 4, 2020'),ken,shoaib),
           triple(date('June 4, 2020'),[doug,jose,apoorv])].

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
   % PairingsNode = pairings(date(Date)),
   % create_node1(PairingsNode, no_semicolon, Pairings),
   % match_node(t, top, Top),
   merge_relation(at, top - PairingsNode, Stmt),
   % str_cat([Top, Pairings, "MERGE ", Rel], Stmt),
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
   write([Stmt|Stmts]), nl,
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

in_triple(A) :-
   triple(_, Trip),
   member(A, Trip).

already_paired(A, B) :-
   paired(_, A, B) ; paired(_, B, A).

pairs(Date, Pairs) :-
   findall(M, member(M), Ms),
   pair_it(Ms, Pairs, []),
   (delete(take_me(P), Pairs, Pears) ->
      print_pairs(date(Date), Pears),
      delete(paired(Q, R), Pears, _),
      not(in_triple(Q)),
      not(in_triple(R)),
      print_triple(date(Date), [P, Q, R])
   ;
      print_pairs(date(Date), Pairs)).

print_term(Term) :- print(Term), write('.'), nl.

print_triple(Date, Trip) :-
   Term =.. [triple, Date, Trip],
   print_term(Term).

print_pairs(_, []).
print_pairs(Date, [H|T]) :-
   H =.. [Fn, A, B],
   Term =.. [Fn, Date, A, B],
   print_term(Term),
   print_pairs(Date, T).

pair_it([]) --> [].
pair_it([H]) --> [take_me(H)].
pair_it([H|T]) -->
   { delete(R, T, Q),
     not(already_paired(H, R)) },
   [paired(H, R)],
   pair_it(Q).

/*
TODO: move pairs to graph database
TODO: read last 5 sets of pairs from graph database.
TODO: Hi, Mom!
*/
