/*

P54 (*) Check whether a given term represents a binary tree

https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/

A binary tree is either empty or it is composed of a root element and two 
successors, which are binary trees themselves.

In Prolog we represent the empty tree by the atom 'nil' and the non-empty tree 
by the term t(X,L,R), where X denotes the root node and L and R denote the left 
and right subtree, respectively. The example tree depicted opposite is 
therefore represented by the following Prolog term:

T1 = t(a,t(b,t(d,nil,nil),t(e,nil,nil)),t(c,nil,t(f,t(g,nil,nil),nil)))

Other examples are a binary tree that consists of a root node only:

T2 = t(a,nil,nil) or an empty binary tree: T3 = nil

You can check your predicates using these example trees. They are given as test 
cases in p54.pl.

Write a predicate istree/1 which succeeds if and only if its argument is a 
Prolog term representing a binary tree.

Example:

?- istree(t(a,t(b,nil,nil),nil)).
Yes
?- istree(t(a,t(b,nil,nil))).
No

*/

istree(nil).
istree(t(_Node,Left,Right)) :-
   istree(Left),
   istree(Right).
