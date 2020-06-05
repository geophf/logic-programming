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

paired(date('May 21, 2020'), len, howie).   /* triple */
paired(date('May 21, 2020'), ray, nichole).
paired(date('May 21, 2020'), morgan, jose).
paired(date('May 21, 2020'), howie, tony).  /* triple */
paired(date('May 21, 2020'), shoaib, apoorv).
paired(date('May 21, 2020'), ken, doug).

/* week 2: may 28 */

paired(date('May 28, 2020'), len, apoorv).
paired(date('May 28, 2020'), ray, shoaib).   /* triple */
paired(date('May 28, 2020'), morgan, nichole).
paired(date('May 28, 2020'), howie, jose).
paired(date('May 28, 2020'), shoaib, doug).  /* triple */
paired(date('May 28, 2020'), ken, tony).

/* week 3: jun 04 */

paired(date('June 4, 2020'),len,ray).
paired(date('June 4, 2020'),howie,nicole).
paired(date('June 4, 2020'),morgan,tony).
paired(date('June 4, 2020'),jose,apoorv).
paired(date('June 4, 2020'),ken,shoaib).

triple(date('June 4, 2020'),[doug,jose,apoorv]).
triple(date('May 21, 2020'), [len, howie, tony]).
triple(date('May 28, 2020'), [ray, shoaib, doug]).

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

delete(H, [H|T], T).
delete(P, [H|T], [H|R]) :-
   delete(P, T, R).
delete(_, [], []).

/*
TODO: move pairs to graph database
TODO: read last 5 sets of pairs from graph database.
TODO: Hi, Mom!
*/
