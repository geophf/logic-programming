/* --------------------------------------------------------------
 * p03_element_at.pl

P03 (*) Find the K'th element of a list.
The first element in the list is number 1.
Example:
?- element_at(X,[a,b,c,d,e],3).
X = c

 */

element_at(X, [X|_], 1).  /* 1-biased 1-based. */
element_at(X, [_|T], N) :-
   M is N - 1,
   element_at(X, T, M).
