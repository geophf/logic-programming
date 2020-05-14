/*
P62 (*) Collect the internal nodes of a binary tree in a list

An internal node of a binary tree has either one or two non-empty successors. 
Write a predicate internals/2 to collect them in a list.

% internals(T,S) :- S is the list of internal nodes of the binary tree T.
*/

:- ['utils/json'].
:- ['utils/avl'].

:- ['p99/movie_db'].
:- ['p99/p61_count_leaves'].

internals(Tree, Nodes) :- internals1(Tree, Nodes, []).

has_child(t(_, _, _, _, _)).

internals1(t) --> [].
internals1(t(K, V, L, R, _)) -->
   { has_child(L); has_child(R) },
   [K-V],
   internals1(L),
   internals1(R).
internals1(t(_, _, t, t, _)) --> [].

/*
Let's go to data.gov. ... nah. We can parse some movies, or use the bowling
stats in utils/json. ... or movies, as a prolog database.

So we have movies by genre and year, let's consume them by genre and store
them with their year.
*/

movie_tree(Movies) :-
   findall(G - movie(T, Y), (movie(T, G, Y)), Ms),
   reduce(putter, t, Ms, Movies).

putter(G - Movie, M0, Movies) :-
   avl_alter_f(M0, G, [Movie], concat(Movie), Movies).

concat(H, T, [H|T]).

/*
Now that we have all 50 billion movies (not really). Let's see how many genres
we have:

?- movie_tree(Movies), 
   findall(Genre, (avl_pick(Genre,_,Movies)), Genres), 
   length(Genres, Len).

Genres = [genre('horror film'), genre('documentary film'), ...]
Len = 97 

The internals (the point of this exercise):

?- movie_tree(Movies), internals(Movies, Ints), length(Ints, Len).
Ints = [genre('horror film')-[movie(title('Girl on the Third Floor'), ...], ...]
Len = 54

?- count_leaves(Movies, Leafs).
Leafs = 43

... which is 97. YES!
*/

/* ------------------------------------------------------- 62B (or not 2B) ----

P62B (*) Collect the nodes at a given level in a list
A node of a binary tree is at level N if the path from the root to the node 
has length N-1. The root node is at level 1. Write a predicate atlevel/3 to 
collect all nodes at a given level in a list.

% atlevel(T,L,S) :- S is the list of nodes of the binary tree T at level L

Using atlevel/3 it is easy to construct a predicate levelorder/2 which creates 
the level-order sequence of the nodes. However, there are more efficient ways 
to do that.
*/

atlevel(Tree, Level, Nodes) :- atlevel1(Tree, Level, Nodes, []).

atlevel1(t, _) --> [].
atlevel1(t(K, V, _, _, _), 1) --> [K-V].
atlevel1(t(_, _, L, R, _), N) -->
   { N > 1,
     pred(N, M) },
   atlevel1(L, M),
   atlevel1(R, M).

/*
?- movie_tree(t(K, _, _, _, Depth)).
K = genre('horror film'),
Depth=8

?- movie_tree(Movies), atlevel(Movies, 5, Collect), length(Collect, Len).
Movies=t(genre('horror film'),[movie(title('Girl on the Third Floor'), ...])).
Collect=[genre('LGBT-related film')-[movie(title('Trapped: The Alex Cooper...
Len=16

yes
*/
