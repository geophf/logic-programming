/*
P57 (**) Binary search trees (dictionaries)

Use the predicate add/3, developed in chapter 4 of the course, to write a 
predicate to construct a binary search tree from a list of integer numbers.

Example:

?- construct([3,2,5,7,1],T).
T = t(3, t(2, t(1, nil, nil), nil), t(5, nil, t(7, nil, nil)))

Then use this predicate to test the solution of the problem P56.

Example:

?- test_symmetric([5,3,18,1,4,12,21]).
Yes
?- test_symmetric([3,2,5,7,4]).
No
*/

construct([]) --> [].
construct([H|T]) --> add(H), construct(T).

add(Elt, T, T1) :-
   term_hash(Elt, Hash),
   add1(hashed(Hash, Elt), T, T1).

add1(H, nil, t(H, nil, nil)).
add1(hashed(Hash, _), T, T) :-
   T = t(hashed(Hash, _), _, _).
add1(H, T, Tree) :-
   T = t(H1, L, R), Tree),
   H = hashed(Hash, _),
   H1 = hashed(HashE, _),
   (Hash < HashE -> addL(H, T, Tree) ; addR(H, T, Tree)).

addL(H, t(H1, nil, R), t(H1, t(H, nil, nil), R)).
addL(H, t(H1, L, R), t(H3, NewL, R)) :-
   L = t(H2, _, _),
   H = hashed(Hash, _),
   H2 = hashed(HashE, _),
   (Hash < HashE -> addL(H, L, NewL), H3 = H1
                  ;  ... and ... what? add1(H, T, Tree)).

to_list(nil, []).
to_list(t(Datum, L, R), List) :-
   to_list(L, Ls),
   to_list(R, Rs),
   append(Ls, [Datum|Rs], List).

/*

hmmmm: https://en.wikipedia.org/wiki/Weight-balanced_tree

*/
