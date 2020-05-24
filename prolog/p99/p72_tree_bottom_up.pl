/*
P72 (*) Construct the bottom-up order sequence of the tree nodes

Write a predicate bottom_up(Tree,Seq) which constructs the bottom-up sequence 
of the nodes of the multiway tree Tree. Seq should be a Prolog list. What 
happens if you run your predicate backwards?
*/

/*
I think this approach is to traverse to the leaves, creating bread crumbs as
we go down, then, breath-first 'up,' as it were, from the leaves back.

Sounds rather heap-ish.
*/

:- ['utils/heap'].
:- ['utils/math'].
:- ['library/ppt'].

/* leaves/2 are of the form [D - Val|...]
   where D is the depth of the leaf and Val is its value.
   ... indicates the trail leading back up to the root node of the form
   D - Val for each node all the way back up */

leaves(Tree, Leaves) :-
   find_leaves(Tree, 0, [], leaf, Leaves).

find_leaves(t(Val, []), N, Trail) -->
   insert([N - Val|Trail]).
find_leaves(t(D, [H|T]), N, Trail) -->
   { succ(N, M),
     T1 = [N - D|Trail] },
   find_leaves(H, M, T1),
   find_each_leaf_in(T, M, T1).

find_each_leaf_in([], _, _) --> nupe.
find_each_leaf_in([H|T], N, Trail) -->
   find_leaves(H, N, Trail),
   find_each_leaf_in(T, N, Trail).

nupe(Heap, Heap).   % this is actually the name of the predicate. I patented it.

/*
So, for the mwt:

Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])])

the leaves are:

?- Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])]),
   leaves(Tree, Heap).

Heap=node(node(node(leaf,[2-e,1-b,0-a],node(leaf,[2-g,1-f,0-a],leaf,1),1),
               [2-d,1-b,0-a],leaf,1),
          [1-c,0-a],leaf,1)

yes

So, now all we have to do is to take the top leaf off the heap, store that
in an AVL, key of depth, reinsert it with the leaf removed from the trail,
and lather, rinse, and repeat until the heap is empty.

That's step one.

Step two is to reverse-sort the AVL by depth, remove the depths, then flatten
the list of lists, and ...

... wait. We must remove duplicate elements.

Hm. A bit further study is required here.

(we can artificially simplify a bit here as this mwt is also a set, ... we
can't do that elsewhere, but, hey! we'll burn that bridge after we cross it. ;)
*/

bottom_up(Tree, Seq) :- true.   % place-holder until we work our magic.
