/* Some list routines */

repeat(0, _, []).
repeat(N, Elt,  [Elt|List]) :-
   N > 0,
   M is N - 1,
   repeat(M, Elt, List).

take(_,1,[]).
take([H|T],N,[H|List]) :-
   N > 1,
   N1 is N - 1,
   take(T, N1, List).
