/* --------------------------------------------------------------
 * p03_element_at.pl
 */

element_at(X, [X|_], 1).  /* 1-biased 1-based. */
element_at(X, [_|T], N) :-
   M is N - 1,
   element_at(X, T, M).
