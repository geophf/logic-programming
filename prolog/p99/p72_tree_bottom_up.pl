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

:- ['utils/cat'].
:- ['utils/avl'].
:- ['utils/heap'].
:- ['utils/math'].
:- ['library/tree'].

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

/* tiered/2 de-heaps the heap as an tiered AVL tree of AVL trees (no dups) */

tiered(Heap, AVL) :-
   heap_to_list(Heap, Lists),
   flatten(Lists, List),
   reduce(insert_at, t, List, AVL).

put_in_avl(Val, T0, T1) :- avl_replace(T0, Val, T1).

insert_at(Tier - Val, A0, AVL) :-
   avl_put(t, Val, Fresh),
   avl_alter_f(A0, Tier, Fresh, put_in_avl(Val), AVL).

/*
tiered1(leaf) --> nupe.
tiered1(Heap) -->
   { delete_min(Heap, [Depth - Val|Trail], Hop),
     (Trail = [_|_] -> insert(Trail, Hop, Hoop) ; Hoop = Hop) },
   insert_at(Depth, Val),
   tiered1(Hoop).

eh, now that I have nodes-with-depth in the heap, I can just heap_to_list/2
and insert them all, pel mel, letting the tiering of the AVL tree maintain
proper ordering.
*/

/* With tiered/2 we have an tiered-AVL of AVLs, so we snarf in reverse order */

bottom_up(Tree, Seq) :-
   leaves(Tree, Leaves),
   tiered(Leaves, Tiers),
   avl_to_list(Tiers, List),
   reverse(List, Reved),
   map(sndkeys, Reved, Vals),
   flatten(Vals, Seq).

sndkeys(_ - AVL, List) :-
   avl_to_list(AVL, KVs),
   map(fst, KVs, List).

/*
?- Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])]),
   bottom_up(Tree, Seq).
Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])]),
Seq=[d,e,g,b,c,f,a]

yes

Well, well, well! There you have it.

Or as the Latinists say:

Q.E.D.

... but heaps, AVL trees, and sndkeys/2 for a 1-* problem? Really? smh

Although, reviewing the code, the heap becomes redundant now, as we no longer
care in which order the leave-sets are insert into the AVL tree (as it takes
care of ordering with tiers-as-keys). We can remove the heaping and simply
use a list of lists as store.
*/
