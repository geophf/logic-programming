/*
P82 (*) Cycle from a given node

Write a predicate cycle(G,A,P) to find a closed path (cycle) P starting at a 
given node A in the graph G. The predicate should return all cycles via 
backtracking.
*/

:- ['utils/cat'].
:- ['utils/graph'].

:- ['p99/p80_graph_conversions_2_directed'].

cycle(Graph, A, Path) :-
   /* so we need to find the path A -> ... -> A
      which means we can go back from A and go forward to A at the same time?
      How do we know we don't cycle infinitely?
    */

   graph_path(Graph,A,A,Path).

/*
?- arc_clause2graph_term(Gr),
|    cycle(Gr, u, Path).
Path = [a(u, s), a(s, u)] ;
false.

?- arc_clause2graph_term(Gr),                                                   cycle(Gr, r, Path).
false.

?- arc_clause2graph_term(Gr),                                                   cycle(Gr, s, Path).
Path = [a(s, u), a(u, s)] ;
false.

?- arc_clause2graph_term(Gr),                                                   cycle(Gr, t, Path).
Path = [a(t, t)] ;
false.

?- arc_clause2graph_term(Gr),                                                   cycle(Gr, v, Path).
false.

I'd love to explore this with a longer path, but I need a different graph
for that.
*/
