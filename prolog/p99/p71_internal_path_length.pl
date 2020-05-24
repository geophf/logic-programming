/*
P71 (*) Determine the internal path length of a tree

We define the internal path length of a multiway tree as the total sum of the 
path lengths from the root to all nodes of the tree. By this definition, the 
tree in the figure of problem P70 has an internal path length of 9. Write a 
predicate ipl(Tree,IPL) for the flow pattern (+,-).
*/

% FRIST we need all the nodes of a mwt:

:- ['utils/list'].

nodes(Tree, Nodes) :- nodes1(Tree, Nodes, []).

nodes1(t(A, [])) --> [A].
nodes1(t(A, [H|T])) -->
   [A],
   nodes1(H),
   { map(nodes, T, Nodes),
     flatten(Nodes, Ns) },
   Ns.

% NEXT we need the path-length from root to some node X

path_length(Root, Node, N) :-
   path_length1(Root, Node, 0, N).

path_length1(t(X, _), X, N, N).
path_length1(t(A, [H|T]), X, N, Sum) :-
   not(A = X),
   M is N + 1,
   (path_length1(H, X, M, Sum) ;
    delete(P, T, _),
    path_length1(P, X, M, Sum)).

/*
Let's use the tree from the last exercise:

?- Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])]),
   nodes(Tree, Nodes).

Nodes=[a,b,e,d,c,f,g]
yes

?- path_length(Tree, g, N).
N=2

With the above, we just sum the path_lengths of the nodes of the tree.
*/

ipl(Tree, Sum) :-
   nodes(Tree, Nodes),
   reduce(path_length_plus(Tree), 0, Nodes, Sum).

path_length_plus(Tree, Node, Accum, Sum) :-
   path_length(Tree, Node, N),
   Sum is Accum + N.

/*
?- ipl(Tree, Sum).
Sum = 9

yes
*/
