/* --------------------------------------------------------------
 * p08_compress.pl

P08 (**) Eliminate consecutive duplicates of list elements.

If a list contains repeated elements they should be replaced with a single copy 
of the element. The order of the elements should not be changed.

Example:
?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [a,b,c,a,d,e]
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
