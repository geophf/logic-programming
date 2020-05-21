/*
P70C (*) Count the nodes of a multiway tree

Write a predicate nnodes/1 which counts the nodes of a given multiway tree.

Example:

?- nnodes(t(a,[t(f,[])]),N).
N = 2

Write another version of the predicate that allows for a flow pattern (o,i).
*/

:- ['utils/list'].

nnodes(t(_, []), 1).
nnodes(t(_, [H|T]), N) :-
   nnodes(H, M),
   map(nnodes, T, Ns),
   reduce(+, 0, Ns, Sum),
   N is M + Sum + 1.

/*
And I didn't have to do anything to go the other way:

?- nnodes(T, 4).
T=t(_x2477,[t(_x2500,[]),t(_x2520,[]),t(_x2540,[])])

yes

But the fail-case hangs :(
*/
