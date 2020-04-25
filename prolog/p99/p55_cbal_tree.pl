:- ['library/tree'].

/*
P55 (**) Construct completely balanced binary trees

In a completely balanced binary tree, the following property holds for every 
node: The number of nodes in its left subtree and the number of nodes in its 
right subtree are almost equal, which means their difference is not greater 
than one.

Write a predicate cbal_tree/2 to construct completely balanced binary trees for 
a given number of nodes. The predicate should generate all solutions via 
backtracking. Put the letter 'x' as information into all nodes of the tree.

Example:

?- cbal_tree(4,T), ppt(T).     % ppt pretty-prints a term as a tree.

T = t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil))) ;
T = t(x, t(x, nil, nil), t(x, t(x, nil, nil), nil)) ;
etc......No
*/

nodes(nil, []).
nodes(t(N,L,R), [N|Ans]) :-
   nodes(L,Ls),
   nodes(R,Rs),
   append(Ls,Rs,Ans).

balanced(nil).
balanced(t(_,L,R)) :-
  balanced(L),
  balanced(R),
  nodes(L, Ls),
  nodes(R, Rs),
  within1(Ls,Rs).

within1([], []).
within1([_], []).
within1([], [_]).
within1([_|Ls], [_|Rs]) :- within1(Ls,Rs).

cbal_tree(N, Tree) :-
   cbal_tree1(N,Tree),
   balanced(Tree),
   nodes(Tree,Kidz),
   length(Kidz,N).

cbal_tree1(0, nil).
cbal_tree1(0, t(x,nil, nil)).
cbal_tree1(1, nil).
cbal_tree1(1, t(x,nil, nil)).
cbal_tree1(N, Tree) :-
   N > 1,
   M is N // 2,
   Tree = t(x,L,R),
   cbal_tree1(M,L),
   cbal_tree1(M,R).
