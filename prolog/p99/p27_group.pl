:- ['utils/list'].
:- ['utils/weight_balanced_tree'].

/*
P27 (**) Group the elements of a set into disjoint subsets.

a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 
   3, and 4 persons? Write a predicate that generates all the possibilities via    backtracking.

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
b) Generalize the above predicate in a way that we can specify a list of group sizes and the predicate will return a list of groups.

Example:
?- group([aldo,beat,carla,david,evi,flip,gary,hugo,ida],[2,2,5],Gs).
Gs = [[aldo,beat],[carla,david],[evi,flip,gary,hugo,ida]]
...

Note that we do not want permutations of the group members; i.e. [[aldo,beat],...] is the same solution as [[beat,aldo],...]. However, we make a difference between [[aldo,beat],[carla,david],...] and [[carla,david],[aldo,beat],...].

You may find more about this combinatorial problem in a good book on discrete mathematics under the term "multinomial coefficients".

The solution for group/3 requires we have sets, ... thus my exploration of WBT
(weight-balanced trees) begins, with a paper written by Hirai and Yamamoto:
"Balancing weight-balanced trees," 2011, Cambridge University Press.

Now that we have sets ... kinda ... I think a set of set of sets is the way to 
go?
*/

group(Domain, Partitions, Groups) :-
   group1(Partitions, Groups, tip, tip, Domain, []).

group1([], Ans, Trial, Store) -->
   { not member(Trial, Store),
     insert(Trial, Store, S1),   /* ... but where do we go from here? */
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

/*
Okay, ... this didn't work, because I'm not iterating to the next solution
after solving the first, obvious, one. "Further study is required."
*/
