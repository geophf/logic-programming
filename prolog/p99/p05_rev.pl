/* --------------------------------------------------------------
 * p05_rev.pl

P05 (*) Reverse a list.

rev([], []).
rev(X, [H|T]) :-
  rev(Y, T),
  append(Y, [H], X).

The above is in O(2n)-time. Is there a linear algorithm to reverse a list?
How about this?
*/

rev(X, List) :- rev1(X, [], List).

rev1(Ans, Ans, []).
rev1(X, Ans, [H|T]) :- rev1(X, [H|Ans], T).
