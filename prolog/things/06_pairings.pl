/*
Problem: we need to pair of devs, but not pair them with their previous sets
of pairings (then we need to age-out pairings, too

Solution: voila!
*/

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

/* week 1: may 21 */

paired(len, howie).   /* triple */
paired(ray, nichole).
paired(morgan, jose).
paired(howie, tony).  /* triple */
paired(shoaib, apoorv).
paired(ken, doug).

/* week 2: may 28 */

paired(len, apoorv).
paired(ray, shoaib).   /* triple */
paired(morgan, nichole).
paired(howie, jose).
paired(shoaib, doug).  /* triple */
paired(ken, tony).

triple([len, howie, tony]).
triple([ray, shoaib, doug]).

in_triple(A) :-
   triple(Trip),
   member(A, Trip).

already_paired(A, B) :-
   paired(A, B) ; paired(B, A).

pairs(Pairs) :-
   findall(M, member(M), Ms),
   pair_it(Ms, Pairs, []),
   (delete(take_me(P), Pairs, Pears) ->
      print_pairs(Pears),
      delete(paired(Q, R), Pears, _),
      not(in_triple(Q)),
      not(in_triple(R)),
      print_triple([P, Q, R])
   ;
      print_pairs(Pairs)).

print_triple(Trip) :-
   write('triple('), print(Trip), write(').'), nl.

print_pairs([]).
print_pairs([H|T]) :-
   print(H), write('.'), nl,
   print_pairs(T).

pair_it([]) --> [].
pair_it([H]) --> [take_me(H)].
pair_it([H|T]) -->
   { delete(R, T, Q),
     not(already_paired(H, R)) },
   [paired(H, R)],
   pair_it(Q).

delete(H, [H|T], T).
delete(P, [H|T], [H|R]) :-
   delete(P, T, R).
delete(_, [], []).

/*
TODO: move pairs to graph database
TODO: read last 5 sets of pairs from graph database.
TODO: Hi, Mom!
*/
