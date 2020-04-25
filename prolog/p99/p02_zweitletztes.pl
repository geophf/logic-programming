/* --------------------------------------------------------------
 * p02_zweitletztes.pl
 *

P02 (*) Find the last but one element of a list.
(zweitletztes Element, l'avant-dernier élément)

 */

zweitletztes_element(X, [X, _]).
zweitletztes_element(X, [_|T]) :- zweitletztes_element(X, T).
