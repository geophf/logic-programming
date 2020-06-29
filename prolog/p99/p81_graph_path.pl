/*
P81 (**) Path from one node to another one

Write a predicate path(G,A,B,P) to find an acyclic path P from node A to node b 
in the graph G. The predicate should return all paths via backtracking.
*/

% Let's use the directed graph from problem 80.

:- ['p99/p80_graph_conversions_2_directed'].

:- ['utils/list'].
:- ['utils/cat'].
:- ['utils/avl'].

/*
Recall that:

?- arc_clause2graph_term(Gr).
Gr = digraph([r,s,t,u,v], [a(s,u), a(u,r), a(s,r), a(u,s), a(v,u), a(t,t)]) .

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
graph_path(Graph, A, B, Path) :-
   fst(Graph, Nodes),
   map(dup, Nodes, Dupes),
   list_to_avl(Dupes, Available),
   snd(Graph, Arcs),
   graph_path1(Available, Arcs, A, B, Path).

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

delete_arc(Fn, A, Arc, [Ar|Cs], Rest) :-
    call(Fn, Ar, A),
    Arc = Ar,
    Rest = Cs.
delete_arc(Fn, A, Arc, [Ar|Cs], [Ar|Rest]) :-
    delete_arc(Fn, A, Arc, Cs, Rest).

/*
?- arc_clause2graph_term(Gr),                                                   graph_path(Gr, u, r, Path).
Path = [a(u, r)] ;
Path = [a(u, s), a(s, r)] ;
false.

?- arc_clause2graph_term(Gr),                                                   graph_path(Gr, v, r, Path).
Path = [a(v, u), a(u, r)] ;
Path = [a(v, u), a(u, s), a(s, r)] ;
false.

?- arc_clause2graph_term(Gr),                                                   graph_path(Gr, s, r, Path).
Path = [a(s, u), a(u, r)] ;
Path = [a(s, r)] ;
false.
*/
