/*
70B (*) Check whether a given term represents a multiway tree

Write a predicate istree/1 which succeeds if and only if its argument is a 
Prolog term representing a multiway tree.

Example:

?- istree(t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])).
Yes
*/

:- ['utils/list'].

istree(t(_, List)) :-
   do(istree, List).

/*

?- istree(t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])).
yes

... but, importantly:

?- istree(t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[yo])])])).
no
*/
