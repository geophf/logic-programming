/*
P61 (*) Count the leaves of a binary tree

A leaf is a node with no successors. Write a predicate count_leaves/2 to count 
them.

% count_leaves(T,N) :- the binary tree T has N leaves
*/

/*
First, we can just gather the leaves, then we just count them.

You know, just like this:

P61A (*) Collect the leaves of a binary tree in a list

A leaf is a node with no successors. Write a predicate leaves/2 to collect 
them in a list.

% leaves(T,S) :- S is the list of all leaves of the binary tree T
*/

:- ['utils/cat'].
:- ['utils/avl'].
:- ['utils/list'].
:- ['utils/math'].
:- ['library/tree'].

leaf(t(K, V, t, t, _), K-V).

leaves(Tree, Leaves) :-
   leaves1(Tree, Leaves, []).

leaves1(t) --> [].
leaves1(Tree) -->
   { leaf(Tree, Entry) },
   [Entry].
leaves1(t(_, _, L, R, _)) -->
   leaves1(L),
   leaves1(R).

% ... and then we just count the leaves

count_leaves(Tree, N) :-
   leaves(Tree, Leaves),
   length(Leaves, N).

% so, how about a set of primes?

prime_rib(Lo, Hi, Primes, AVL, Leaves, N) :-
   list_primes(Lo, Hi, Primes),
   map(dup, Primes, Ps),
   list_to_avl(Ps, AVL),
   leaves(AVL, Leaves),
   count_leaves(AVL, N).    % redundant, but this is what we wish to test.

/*
?- prime_rib(2, 100, P, A, L, N), length(L, Len).                          
P=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97],
A=t(53,53,t(19,19,t(7,7,t(3,3,t(2,2,t,t,1),t(5,5,t,t,1),2),t(13,13,...))))
L=[2-2,5-5,11-11,17-17,23-23,31-31,41-41,47-47,59-59,67-67,73-73,83-83,97-97],
N=13,
Len=13

yes
*/
