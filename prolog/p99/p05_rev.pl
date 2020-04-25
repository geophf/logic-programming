/* --------------------------------------------------------------
 * p05_rev.pl

P05 (*) Reverse a list.

 */

rev([], []).
rev(X, [H|T]) :-
  rev(Y, T),
  append(Y, [H], X).

/* The above is in O(2n)-time. Is there a linear algorithm to reverse a list? */



/* --------------------------------------------------------------
 * p06_palindrome.pl
 */

/* :- [p05_rev]. */

palindrome(X) :- rev(X, X).


/* --------------------------------------------------------------
 * p07_flatten.pl
 */

flatten([], []).
flatten([H|T], X) :-
  (is_list(H) -> flatten(H, Y); Y = [H]),
  flatten(T, Z), append(Y, Z, X).

is_list([]).
is_list([_|_]).


/* --------------------------------------------------------------
 * p08_compress.pl
 */

compress([], []).
compress([H|T],[H|X]) :-
   skip(H, T, Z),
   compress(Z, X).

skip(_, [], []).
skip(X, [X|T], Z) :-
   skip(X, T, Z).
skip(X, [H|T], [H|T]) :-
   not H = X.
