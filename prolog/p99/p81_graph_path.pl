/*
P81 (**) Path from one node to another one

Write a predicate path(G,A,B,P) to find an acyclic path P from node A to node b 
in the graph G. The predicate should return all paths via backtracking.
*/

% Let's use the directed graph from problem 80.

% :- ['p99/p80_graph_conversions_2_directed'].

% let's use a cyclic graph:

:- ['p99/p83_spanning_tree'].

:- ['utils/list'].
:- ['utils/cat'].
:- ['utils/avl'].
:- ['utils/graph'].

/*
Note that:

?- spanning_tree_graph(Gr).
Gr = digraph([a, b, c, d, e, f, g, h],
             [a(a, b, 5), a(b, a, 5), a(a, d, 3), 
              a(d, a, 3), a(b, c, 2), a(c, b, 2), 
              a(b, e, 4), a(..., ..., ...)|...]).

and:

?- unpair(a(s,u), A, B).
A = s,
B = u.

?- unpair(a(s,u, 7), A, B).
A = s,
B = u.

So unpair/3 works on a/2 and on a/3.
*/

/*
I need to get from vertex A to vertex B in graph Gr, even though that might
be impossible for some As or Bs
*/

path(Graph, A, B, Path) :-
   fst(Graph, Nodes),
   map(dup, Nodes, Dupes),
   list_to_avl(Dupes, Available),
   snd(Graph, Arcs),
   remove_node(B, Available, Avail),
   graph_path1(Avail, Arcs, A, B, Path).

graph_path1(Available, Arcs, A, B, Path) :-
   delete_arc(fst, A, Arc1, Arcs, Arcs0),
   remove_node(A, Available, Avail),
   (snd(Arc1, B) ->
       Path = [Arc1]
   ;
       delete_arc(snd, B, Brc1, Arcs0, Arcs1),
       fst(Brc1, F),
       remove_node(F, Avail, AVL),
       gp1(AVL, Arcs1, Arc1, Brc1, Path)).

remove_node(Node, Avl0, Avail) :-
   avl_has(Avl0, Node),
   list_to_avl([Node-Node], Visited),
   avl_set_difference(Avl0, Visited, Avail).

gp1(Available, Arcs, Arc1, Brc1, Path) :-
    fst(Brc1, B1),
    snd(Arc1, A1),
    (A1 = B1 ->
       Path = [Arc1, Brc1]
    ;
       graph_path1(Available, Arcs, A1, B1, Path1),
       append([Arc1|Path1], [Brc1], Path)).

/*
?- spanning_tree_graph(Gr), path(Gr, a,b,Path).
Path = [a(a, b, 5)] ;
Path = [a(a, d, 3), a(d, e, 7), a(e, c, 6), a(c, b, 2)] ;
Path = [a(a, d, 3), a(d, f, 4), a(f, g, 4), a(g, h, 1), a(h, e, 5), a(e, c, 6), a(c, b, 2)] ;
Path = [a(a, d, 3), a(d, g, 3), a(g, h, 1), a(h, e, 5), a(e, c, 6), a(c, b, 2)] ;
Path = [a(a, d, 3), a(d, e, 7), a(e, b, 4)] ;
Path = [a(a, d, 3), a(d, f, 4), a(f, g, 4), a(g, h, 1), a(h, e, 5), a(e, b, 4)] ;
Path = [a(a, d, 3), a(d, g, 3), a(g, h, 1), a(h, e, 5), a(e, b, 4)] ;
false.
*/
