/*

% -*- Mode: Prolog -*-


:- module(avl, [ avl_empty/1,
		 avl_to_list/2,
		 avl_put/4,
		 avl_put/3,
		 avl_replace/4,
		 avl_replace/3,
		 avl_get/3,
		 avl_has/2,
		 sorted_list_to_avl/2,
		 list_to_avl/2,
		 avl_gen/3,
		 avl_dump/1]).

*/

:- ['utils/cat'].
:- ['library/tree'].

%  ---+ Introduction
%
%  This module exports a set of predicates to manipulate AVL trees from Prolog.
%
%    ---++ AVL tree representation
%
%    Empty trees are represented as =|t|=.
%
%    Non empty tree nodes are represented as
%      @c|t(Key, Value, Left, Right, Depth)| where
%
%    
%      * Key and Value
%          are the key/value pair stored on this node.
%      * Left and Right
%          are this node child subtrees.
%      * Depth
%          is a value used internally to calculate when
%          the tree needs to be balanced after an insertion.
%    


%% avl_empty(?Tree)
%    creates an empty AVL tree.
%  
avl_empty(t).

%% avl_to_list(+Tree, ?List)
%    @param Tree
%        input AVL tree.
%    @param List=[K1-V1, K2-V2, ...]
%        output sorted list.
%
%     converts an AVL tree to a sorted list with the =|Key-Value|= pairs.
%  
avl_to_list(T, L) :-
	avl_to_list(T, L, []).

avl_to_list(t, L, L).
avl_to_list(t(K, V, L, R, _), List, Rest) :-
	avl_to_list(L, List, [K-V|M]),
	avl_to_list(R, M, Rest).

%% avl_put(+Tree, +Key, -Out)
%  equivalent to @c|avl_put(Tree, Key, [], Out)|. See also avl_put/4.
%  

avl_put(T, K, T1) :-
	avl_put(T, K, [], T1).


%% avl_put(+Tree, +Key, +Value, -Out)
%    @param Tree
%        input AVL tree.
%    @param Key, Value
%        pair to insert on the AVL tree
%    @param Out
%        output tree.
%
%   inserts a =|Key/Value|= pair on an AVL tree. Fails if an
%        element with the same =|Key|= already exists on the tree
%        (see also avl_replace/4).
%
%  
avl_put(t, K, V, t(K, V, t, t, 1)) :- !.
avl_put(t(NK, NV, L, R, D), K, V, T) :-
	compare(O, K, NK),
	avl_put(O, NK, NV, L, R, D, K, V, T).

avl_put(<, NK, NV, L, R, D, K, V, T) :-
	avl_put(L, K, V, L1),
	(   L1 = t(_, _, _, _, D)
	->  avl_balance_left(NK, NV, L1, R, T)
	;   T = t(NK, NV, L1, R, D) ).

avl_put(>, NK, NV, L, R, D, K, V, T) :-
	avl_put(R, K, V, R1),
	(   R1 = t(_, _, _, _, D)
	->  avl_balance_right(NK, NV, L, R1, T)
	;   T = t(NK, NV, L, R1, D) ).

%% avl_replace(+Tree, +Key, -Out)
%    equivalent to @c|avl_replace(Tree, Key, [], Out)|.
%    See also avl_replace/4.
%  

avl_replace(T, K, T1) :-
	avl_replace(T, K, [], T1).

%% avl_replace(+Tree, +Key, +Value, -Out)
%    @param Tree
%        input AVL tree.
%    @param Key, Value
%        pair to insert on the AVL tree
%    @param Out
%        output tree.
%
%     inserts a =|Key/Value|= pair on an AVL tree. If an
%        element with the same =|Key|= already exists on the tree
%        it is replaced (see also avl_put/4).
%  

avl_replace(t, K, V, t(K, V, t, t, 1)) :- !.
avl_replace(t(NK, NV, L, R, D), K, V, T) :-
	compare(O, K, NK),
	avl_replace(O, NK, NV, L, R, D, K, V, T).

avl_replace(=, NK, _, L, R, D, _, V, t(NK, V, L, R, D)).
avl_replace(<, NK, NV, L, R, D, K, V, T) :-
	avl_replace(L, K, V, L1),
	(   L1 = t(_, _, _, _, D)
	->  avl_balance_left(NK, NV, L1, R, T)
	;   T = t(NK, NV, L1, R, D) ).

avl_replace(>, NK, NV, L, R, D, K, V, T) :-
	avl_replace(R, K, V, R1),
	(   R1 = t(_, _, _, _, D)
	->  avl_balance_right(NK, NV, L, R1, T)
	;   T = t(NK, NV, L, R1, D) ).

avl_balance_left(NK, NV, t(LK, LV, LL, LR, LD), R, T) :-
	(   avl_cmp_depth(R, LD, 2)
	->  % avl_dump(t(NK, NV, t(LK, LV, LL, LR, LD),R, _), 'lb: '),nl,
	    (	LR = t(LRK, LRV, LRL, LRR, LRD),
		avl_cmp_depth(LL, LRD, 1)
	    ->	T = t(LRK, LRV, t(LK, LV, LL, LRL, LRD), t(NK, NV, LRR, R, LRD), LD)
	    ;	ND1 is LD-1,
		T = t(LK, LV, LL, t(NK, NV, LR, R, ND1), LD) )
	;   D1 is LD + 1,
	    T = t(NK, NV, t(LK, LV, LL, LR, LD), R, D1) ).
	
avl_balance_right(NK, NV, L, t(RK, RV, RL, RR, RD), T) :-
	(   avl_cmp_depth(L, RD, 2)
	->  % avl_dump(t(NK, NV, L, t(RK, RV, RL, RR, RD), _), 'rb: '),nl,
	    (	RL = t(RLK, RLV, RLL, RLR, RLD),
		avl_cmp_depth(RR, RLD, 1)
	    ->	T = t(RLK, RLV, t(NK, NV, L, RLL, RLD), t(RK, RV, RLR, RR, RLD), RD)
	    ;	ND1 is RD-1,
		T = t(RK, RV, t(NK, NV, L, RL, ND1), RR, RD) )
	;   D1 is RD + 1,
	    T = t(NK, NV, L, t(RK, RV, RL, RR, RD), D1) ).

avl_cmp_depth(t, D, D).
avl_cmp_depth(t(_,_,_,_,AD), BD, D) :-
	D is BD - AD.

%% avl_has(+Tree, +Key)
%    checks whether the AVL tree contains an element with the given key.
% 
avl_has(T, K) :-
	avl_get(T, K, _).

%% avl_get(+Tree, +Key, ?Value)
%    @param Tree
%        input AVL tree
%    @param Key
%        key for the element that wants to be retrieved
%    @param Value
%        value found
%
%     retrieves the value associated to some key. Predicate fails if no element with such key is found on the tree.
%  
avl_get(t(NK, NV, L, R, _), K, V) :-
	compare(O, K, NK),
	avl_get(O, K, NV, L, R, V).
avl_get(=, _,V,_,_,V).
avl_get(<,K,_,L,_,V) :-
	avl_get(L, K, V).
avl_get(>,K,_,_,R,V) :-
	avl_get(R, K, V).

%% list_to_avl(+List, -Tree)
%    @param List=[K1-V1, K2-V2,...]
%        input list to be converted to an AVL tree.
%    @param Tree
%        output AVL tree.
%
%     converts a list of =|Key-Value|= pairs to and AVL tree.
%          Internally, it uses avl_replace/4, so if the list contains
%          several elements with the same key, the first ones are
%          effectively ignored.
%  
list_to_avl(L, O) :-
	list_to_avl(L, t, O).

list_to_avl([], O, O).
list_to_avl([K-V|L], T, O) :-
	avl_replace(T, K, V, T1),
	list_to_avl(L, T1, O).

%% sorted_list_to_avl(+List, -Tree)
%    @param List=[K1-V1, K2-V2, ...]
%        input list to be converted to an AVL tree.
%        It has to be a sorted and elements keys have to be unique.
%    @param Tree
%        output tree.
%  
%     converts a sorted list of =|Key-Value|= pairs without key duplicates
%        to an AVL tree efficiently.
%  
sorted_list_to_avl(List, T) :-
	length(List, E),
	sorted_list_to_avl(E, List, [], _, T1),
	T=T1.

sorted_list_to_avl(0, List, Rest, 0, t) :-
	!,
	List=Rest.
sorted_list_to_avl(1, List, Rest, 1, t(K, V, t, t, 1)) :-
	!,
	List=[K-V|Rest].
sorted_list_to_avl(N, List, Rest, D, t(K, V, L, R, D)) :-
	A is N//2,
	sorted_list_to_avl(A, List, [K-V|More], D1, L),
	D is D1+1,
	Z is N-1-A,
	sorted_list_to_avl(Z, More, Rest, _, R).

%% avl_gen(+Tree, ?Key, ?Value)
%    @param Tree
%        input AVL tree.
%    @param Key, Value
%        pair on the tree.
%  
%     enumerates via backtracking the elements on the AVL tree.
%  
avl_gen(t(_,_,L,_,_), K, V) :-
	avl_gen(L, K, V).
avl_gen(t(K,V,_,_,_), K, V).
avl_gen(t(_,_,_,R,_), K, V) :-
	avl_gen(R, K, V).

%% avl_dump(+Tree)
%    prints an human friendly representation of the tree to the current stream.
%
%    TODO: use @l portray/1
%  instead.
%  

avl_dump(T) :-
	avl_dump(T, '').
avl_dump(t, S) :-
	format('~pt~n', [S]).
avl_dump(t(K, V, L, R, D), S) :-
	format('~pavl ~p=~p (~p)~n', [S, K, V, D]),
	atom_concat(S, '   |', SL),
	avl_dump(L, SL),
	atom_concat(S, '    ', SR),
	avl_dump(R, SR).

/** <module>
  @author Salvador Fandino Garcia <mailto:sfandino@yahoo.com> <sfandino@@yahoo.com>
  
  @license <http://www.fsf.org/licensing/licenses/gpl.html> GPL
  @version  $Revision: 1.1 $
  @date  $Date: 2006/03/25 02:07:05 $*/

/* ----- below predicated added by Doug Auclair, beginning 2020-05-03 ----- */

% avl_pick/3 provides nondeterministic iteration over the AVL tree's elements.

avl_pick(K, V, t(K, V, _, _, _)).
avl_pick(K, V, t(_, _, L, _, _)) :- avl_pick(K, V, L).
avl_pick(K, V, t(_, _, _, R, _)) :- avl_pick(K, V, R).

% avl_alter_f replaces an existing value with the value modified by AlterFn
% or, if the value is not there, adds the default V
%
% avl_alter_f/5 uses apply/3 from my utils/cat library.

avl_alter_f(t, K, V, _, t(K, V, t, t, 1)) :- !.
avl_alter_f(t(NK, NV, L, R, D), K, V, AlterF, T) :-
   compare(O, K, NK),
   avl_alter_f1(O, NK, NV, L, R, D, K, V, AlterF, T).

avl_alter_f1(=, NK, V0, L, R, D, _, _, AlterF, t(NK, V, L, R, D)) :-
   apply(AlterF, V0, F0),
   apply(F0, V, Fn),
   call(Fn).
avl_alter_f1(<, NK, NV, L, R, D, K, V, AlterF, T) :-
        avl_alter_f(L, K, V, AlterF, L1),
        (   L1 = t(_, _, _, _, D)
        ->  avl_balance_left(NK, NV, L1, R, T)
        ;   T = t(NK, NV, L1, R, D) ).
avl_alter_f1(>, NK, NV, L, R, D, K, V, AlterF, T) :-
        avl_alter_f(R, K, V, AlterF, R1),
        (   R1 = t(_, _, _, _, D)
        ->  avl_balance_right(NK, NV, L, R1, T)
        ;   T = t(NK, NV, L, R1, D) ).

% why hadn't I thought of this before? ... because avl_gen kinda does this ...

avl_keys(Tree, Keys) :-
   avl_keys1(Tree, Keys, []).

avl_keys1(t) --> [].
avl_keys1(t(K, _V, L, R, _D)) -->
   avl_keys1(L),
   [K],
   avl_keys1(R).

avl_set_difference(AVL0, AVL1, Diff) :-
   avl_keys(AVL0, Keys0),
   avl_empty(E),
   reduce_from(asd1, AVL1, E, Keys0, Diff).

/*
Actually we want to do a complex reduction where, when we get a hit on a key
we also want to remove that key from the operand AVL tree, until we have an
empty tree, then we just do a merge of list_to_avl/3 with a given avl.
*/

avl_add(Elt, T0, AVL) :-
   avl_replace(T0, Elt, AVL).

asd1(AVL, Key) -->
   { avl_has(AVL, Key) } ->
      id
   ;
      avl_add(Key).

% To do a more efficient avl_set_difference, we need an effective avl_remove

/*
Algorithm/Insights
We will try to understand this algorithm using an example but before that let's 
go over the major steps of this algorithm. Note that this algorithm is a 
bottom-up algorithm and hence height restoration of the tree proceeds from 
leaves to root.

This algorithm is basically a modification of the usual BST deletion algorithm. 
The steps of this algorithm are -

1. Use general BST deletion algorithm to delete given key from the AVL tree.
2. After deletion, update the height of the current node of the AVL tree.
3. Now check the 'balance' at the current node by getting the difference of 
   height of left sub-tree and height of right sub-tree.
3a. If 'balance' > 1 then that means the height of the left sub-tree is greater 
    than the height of the right sub-tree. This indicates left-left or 
    left-right case(discussed in the previous post). To confirm if this is 
    left-left or left-right case, we check the balance of left sub-tree of 
    current node. If it greater than 0 then that confirms left-left case, if it     less than 0 then that confirms left-right case. If it is equal to 0, then       this we can either consider this as a left-left case or as a left-right 
    case. In this implementation, we consider this as left-left case for 
    efficiency. For left-left case, we do a right rotation at the current node. 
    For the left-right case, we do a left rotation at left child of current 
    node followed by a right rotation at the current node itself.
3b. If 'balance' < -1 then that means the height of the right sub-tree is 
    greater than the height of the left sub-tree. This indicates right-right 
    or right-left case(discussed in the previous post). In this case, if 
    balance of right sub-tree of current node is less than 0 then this confirms 
    right-right case, if it is greater than 0 then this confirms right-left 
    case. If it is equal to 0, then we can either consider this as a right-right
    case or a right-left case. In this implementation, we will consider this as 
    a right-right case. In right-right case, we do a left rotation at the 
    current node. In right-left case, we do a right rotation at the right child 
    of current node followed by left rotation at the current node itself.
*/

