/*
P41 (**) A list of Goldbach compositions.

part I:

Given a range of integers by its lower and upper limit, print a list of all 
even numbers and their Goldbach composition.

Example:

?- goldbach_list(9,20).
10 = 3 + 7
12 = 5 + 7
14 = 3 + 11
16 = 3 + 13
18 = 5 + 13
20 = 3 + 17
*/

:- ['utils/cat'].
:- ['utils/list'].
:- ['utils/math'].
:- ['utils/avl'].

/*
goldbach_list(Lo, Hi, List) :-
   max(Lo, 4, LowerLimit),
   range(LowerLimit, Hi, Range),
   filter(even, Range, Evens),
   map(goldbacher, Evens, List).

goldbacher(Even, Even = P + P1) :-
   goldbach(Even, [P, P1]).

?- goldbach_list(9, 20, List).
List=[10 = 3+7,12 = 5+7,14 = 3+11,16 = 3+13,18 = 5+13,20 = 3+17]

yes

But:

?- goldbach_list(1,1000,L).
*** trail overflow by 0 bytes (safety left: 2056 bytes)
culprit=>trailing in unify

So, we n eed to move away from the naive implementation.

Our plan of attack here is to:

1.  build an AVL tree of primes up to the even number tested
2.  pick/2 a number from that tree
3.  verify its dual is in the tree
4.  grow the tree for each even number tested.

The resulting implementation is fast (search in O(log n)-time) and space-
efficient.
*/

avl(Ps, AVL) :-
   map(dup, Ps, Qs),
   list_to_avl(Qs, AVL).

goldbach_list(Lo, Hi, List) :-
   setup(Lo, Hi, Evens, Primes, AVL),
   reduce_goldbacher(AVL, Primes, Evens, List, []).

setup(Lo, Hi, Evens, Rs, AVL) :-
   max(Lo, 4, LowerLimit),
   range(LowerLimit, Hi, Range),
   filter(even, Range, Evens),
   list_primes(2, Hi, Primes),
   partition(lt(LowerLimit), Primes, Ps, Rs),
   avl(Ps, AVL).

pick(P, t(_, P, _, _, _)).
pick(Q, t(_, _, L, _, _)) :- pick(Q, L).
pick(Q, t(_, _, _, R, _)) :- pick(Q, R).

lt(V1, V2) :- V2 < V1.

reduce_goldbacher(_, _, []) --> [].
reduce_goldbacher(A, Primes, [E|Vens]) -->
   { insert_prime(A, E, Primes, A1, Imes),
     goldbacher(A1, E, Eq) },
   [Eq], 
   reduce_goldbacher(A1, Imes, Vens).

insert_prime(A, _, [], A, []).
insert_prime(A, E, [Pr|Imes], A1, Imes) :-
   Pr < E,
   avl_put(A, Pr, Pr, A1).
insert_prime(A, E, [Pr|Imes], A, [Pr|Imes]) :-
   Pr >= E.

goldbacher(AVL, Even, Even = P + P1) :-
   pick(P, AVL),
   P1 is Even - P,
   avl_has(AVL, P1).

/*
part II:

In most cases, if an even number is written as the sum of two prime numbers, 
one of them is very small. Very rarely, the primes are both bigger than say 50. 
Try to find out how many such cases there are in the range 2..3000.

Example (for a print limit of 50):

?- goldbach_list(1,2000,50).
992 = 73 + 919
1382 = 61 + 1321
1856 = 67 + 1789
1928 = 61 + 1867

goldbach_list(Lo, Hi, Min, List) :-
   min(Lo, 4, LowerLimit),
   range(LowerLimit, Hi, Range),
   filter(even, Range, Evens),
   map(goldbacher, Evens, GBs),
   goldbach_list1(Min, GBs, List).

... again, leveraging the work done in goldbach_list:
*/

goldbach_list1(Lo, Hi, Min, List) :-
   goldbach_list(Lo, Hi, GBs),
   filter(ge(Min), GBs, List).

ge(N, _ = P + P1) :-
   N =< P,
   N =< P1.

/*
?- goldbach_list1(1, 2000, 50, L), length(L, Len).
L=[106 = 53+53,112 = 53+59,114 = 53+61,120 = 53+67,124 = 53+71,126 = 53+73,...
Len=537

yes
*/

/* let's move the comparison functionals to the library utils/cat */
