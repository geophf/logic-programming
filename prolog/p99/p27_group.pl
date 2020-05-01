:- ['utils/list'].
/* :- ['utils/weight_balanced_tree']. */

/*
P27 (**) Group the elements of a set into disjoint subsets.

a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 
   3, and 4 persons? Write a predicate that generates all the possibilities via 
   backtracking.

Example:

?- group3([aldo,beat,carla,david,evi,flip,gary,hugo,ida],G1,G2,G3).
G1 = [aldo,beat], G2 = [carla,david,evi], G3 = [flip,gary,hugo,ida]
...
*/

group3(Group, A, B, C) :- group3dcg(A, B, C, Group, []).

group3dcg(A,B,C) -->
  pickN(2, A),
  pickN(3, B),
  pickN(4, C).

/*
b) Generalize the above predicate in a way that we can specify a list of group 
   sizes and the predicate will return a list of groups.

Example:

?- group([aldo,beat,carla,david,evi,flip,gary,hugo,ida],[2,2,5],Gs).
Gs = [[aldo,beat],[carla,david],[evi,flip,gary,hugo,ida]]
...

Note that we do not want permutations of the group members; 

i.e. [[aldo,beat],...] is the same solution as [[beat,aldo],...]. 

However, we make a difference 

between [[aldo,beat],[carla,david],...] and [[carla,david],[aldo,beat],...].

You may find more about this combinatorial problem in a good book on discrete 
mathematics under the term "multinomial coefficients".

The solution for group/3 requires we have sets, ... thus my exploration of WBT
(weight-balanced trees) begins, with a paper written by Hirai and Yamamoto:
"Balancing weight-balanced trees," 2011, Cambridge University Press.

Now that we have sets ... kinda ... I think a set of set of sets is the way to 
go?

group(Domain, Partitions, Groups) :-
   group1(Partitions, Groups, tip, tip, Domain, []).

group1([], Ans, Trial, Store) -->
   { not member(Trial, Store),
     insert(Trial, Store, S1),   ... but where do we go from here?
     to_lists(Trial, Ans) }.
group1([N|Rest], Ans, Trial, Store) -->
   pickN(N, Pick),
   { insert_list(Pick, tip, Group),
     insert(Group, Trial, T1) },
   group1(Rest, Ans, T1, Store).

to_lists(Tree, Ans) :-
   to_list(Tree, SubTrees),
   to_lists1(SubTrees, Ans, []).

to_lists1([]) --> [].
to_lists1([H|T]) --> 
   { to_list(H, Hs) },
   [Hs],
   to_lists1(T).

Okay, ... this didn't work, because I'm not iterating to the next solution
after solving the first, obvious, one. "Further study is required."

"Further study"

Actually, it's quite simple

[A, B, C, ...] are the groups where

group A is two elements from the original list, but in order!

Why 'in order'? Because a set is a set, regardless of order, so we can make
a list a set by ensuring that every combination of the sets are used once.
And we can do that with an in-order traversal of the domain.

Voila! Sets-fo'-free... kinda.
*/

group(Domain, Partitions, Groups) :-
   group1(Partitions, Groups, Domain, []).

pick1_1(H, [H|T], T).
pick1_1(P, [_|T], L) :-
   pick1_1(P, T, L).

pickN_1(0, []) --> [].
pickN_1(N, [P|Ans]) -->
   { N > 0,
     M is N - 1 },
   pick1_1(P),
   pickN_1(M, Ans).

group1([], []) --> [].
group1([N|Rest], [Pick|Ans]) -->
   pickN_1(N, Pick),
   group1(Rest, Ans).

/*
Okay, ... this solution generates one solution, the first solution with all
names in order, then no other solutions, so it's something with my picks-
predicates. I need to pick, then to narrow the list by the picked values 
while still maintaining the in-orderness of the original list.

So, ... progress?-.. ish?
*/
