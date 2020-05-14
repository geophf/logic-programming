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

