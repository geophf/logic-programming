/*
Problem: we need to pair of devs, but not pair them with their previous sets
of pairings (then we need to age-out pairings, too

Solution: voila!
*/

:- ['utils/list'].
:- ['utils/neo4j'].
:- ['utils/cypher'].
:- ['utils/str'].

jigsawyers(Members) :-
   query_graph_store('TEAM_PAIRING',
                     ["MATCH (p:Jigsawyer) RETURN p"], Response),
   Response = result_set(data(Rows), _, _),
   flatten(Rows, Names),
   map(extract(name), Names, Members).

% NamesStr is the names you want to add, e.g.: "Bob Joe Fred" ...

upload_names(NamesStr) :-
   words(NamesStr, Names),
   map(tt_cn, Names, Cyphs),
   store_graph('TEAM_PAIRING', Cyphs).

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

/*

% week 1: may 21

paired(date('May 21, 2020'), len, howie).   /* triple */
paired(date('May 21, 2020'), ray, nichole).
paired(date('May 21, 2020'), morgan, jose).
paired(date('May 21, 2020'), howie, tony).  /* triple */
paired(date('May 21, 2020'), shoaib, apoorv).
paired(date('May 21, 2020'), ken, doug).

% week 2: may 28

paired(date('May 28, 2020'), len, apoorv).
paired(date('May 28, 2020'), ray, shoaib).   /* triple */
paired(date('May 28, 2020'), morgan, nichole).
paired(date('May 28, 2020'), howie, jose).
paired(date('May 28, 2020'), shoaib, doug).  /* triple */
paired(date('May 28, 2020'), ken, tony).

% week 3: jun 04

paired(date('June 4, 2020'),len,ray).
paired(date('June 4, 2020'),howie,nicole).
paired(date('June 4, 2020'),morgan,tony).
paired(date('June 4, 2020'),jose,apoorv).    /* triple */
paired(date('June 4, 2020'),ken,shoaib).

triple(date('June 4, 2020'),[doug,jose,apoorv]).
triple(date('May 21, 2020'), [len, howie, tony]).
triple(date('May 28, 2020'), [ray, shoaib, doug]).

We need to upload these data to the graph store, I'm thinking

(a)-[:PAIRED on: date]->(b) ...

then have

(:LastPairings)-[:FOLLOWS]->(:Pairings date: date)-[:FOLLOWS]->(:Pairings ...)

And pull the :PAIRED for the dates on the last n slowbacks.
*/

/*
So, FRIST!

GIVEN: we've [somehow] [magically] created the pairs and triples for today,
Let's add to our pairs-sets, uploading the pairs for today.

SO, FRIST!

We want to get the 'LastSlowback' and the link to its date, then link today's
slowback to last slowback (deleting that old link), and pointing today's
slowback as last slowback.

We ASSUME that today's slowback is alreadly linked with its pairs.
*/

link_pairings(_Date, _Pairings) :-
   true.

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
