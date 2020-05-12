/*
We design the heap as a 'leftist tree' a la:

http://typeocaml.com/2015/03/12/heap-leftist-tree/
*/

:- ['utils/math'].
:- ['library/tree'].

singleton(K, node(leaf, K, leaf, 1)).

rank(leaf, 0).
rank(node(_, _, _, R), R).

rank1(T, R) :-
   rank(T, R0),
   succ(R0, R).

merge(leaf, T, T).
merge(T, leaf, T).
merge(T1, T2, Heap) :-
   T1 = node(_, K1, _, _), 
   T2 = node(_, K2, _, _),
   compare(O, K1, K2),
   merge1(O, T1, T2, Heap).

merge1(>, T1, T2, Heap) :-
   do_merge(T2, T1, Heap).
merge1(O, T1, T2, Heap) :-
   member(O, [=, <]),
   do_merge(T1, T2, Heap).

do_merge(T1, T2, Heap) :-
   T1 = node(L, K1, R, _),
   % T2 = node(_, _, _, _), ... redundant: this structure is known from merge/3
   merge(R, T2, Merged),
   rank1(L, Rank_Left),
   rank1(R, Rank_Right),
   compare(O, Rank_Left, Rank_Right),
   dodo_merge(O, L, Merged, K1, Rank_Left, Rank_Right, Heap).

dodo_merge(<, L, Merged, K1, Rank_Left, _, node(Merged, K1, L, Rank_Left)).
dodo_merge(O, L, Merged, K1, _, Rank_Right, node(L, K1, Merged, Rank_Right)) :-
   member(O, [>, =]).

insert(X, T0, T) :-
   singleton(X, S),
   merge(S, T0, T).

list_to_heap(List, Heap) :- reduce(insert, leaf, List, Heap).

heap_to_list(Heap, List) :-
   heap_to_list1(Heap, List, []).

heap_to_list1(Heap) -->
   { delete_min(Heap, K, Rest) } ->
   [K],
   heap_to_list1(Rest)
   ;
   [].

/*
?- list_to_heap([2,7,17,3,19,100,36,25,1], Heap).
Heap=node(leaf,1,node(node(leaf,7,node(leaf,17,leaf,1),1),...),1)

yes

and ppt(Heap) shows the (tree) structure of the heap.
*/

get_min(node(_, K, _, _), K).
delete_min(node(L, K, R, _), K, T) :- merge(L, R, T).
