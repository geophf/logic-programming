/* --------------------------------------------------------------
 * p02_zweitletztes.pl
 *

P02 (*) Find the last but one element of a list.
(zweitletztes Element, l'avant-dernier élément)

 */

zweitletztes_element(X, [X, _]).
zweitletztes_element(X, [_|T]) :- zweitletztes_element(X, T).



/* --------------------------------------------------------------
 * p03_element_at.pl
 */

element_at(X, [X|_], 1).  /* 1-biased 1-based. */
element_at(X, [_|T], N) :-
   M is N - 1,
   element_at(X, T, M).


/* --------------------------------------------------------------
 * p04_len.pl
 */

len(0, []).
len(Y, [_|T]) :-
   len(X, T),
   Y is X + 1.


/* --------------------------------------------------------------
 * p05_rev.pl
 */

rev([], []).
rev(X, [H|T]) :-
  rev(Y, T),
  append(Y, [H], X).


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
