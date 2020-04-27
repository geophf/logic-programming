/* Some list routines */

repeat(0, _, []).
repeat(N, Elt,  [Elt|List]) :-
   N > 0,
   M is N - 1,
   repeat(M, Elt, List).
