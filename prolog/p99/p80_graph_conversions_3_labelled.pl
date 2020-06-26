:- ['utils/avl'].
:- ['utils/list'].

arc(m,q,7).
arc(p,q,9).
arc(p,m,5).

arc_clause2graph_term(Diagraph) :-
   arc_clauses(Arcs1),
   arc_clause_list2graph_term(Arcs1, Diagraph).

arc_clauses(Arcs) :-
   findall(Arc, (arc(A, B, L), Arc = arc(A, B, L)), Arcs).

arc_clause_list2graph_term(ArcClauses, digraph(Nodes,Arcs)) :-
   collect_nodes(ArcClauses, Nodes),
   map(arc2a, ArcClauses, Arcs).

arc2a(arc(A, B, L), a(A, B, L)).

putter(arc(N0, N1, _L), T0, Tree) :- 
   avl_replace(T0, N0, T1),
   avl_replace(T1, N1, Tree).

collect_nodes(Arcs, Nodes) :-
   avl_empty(Empty),
   reduce(putter, Empty, Arcs, Tree),
   avl_keys(Tree, Nodes).

/*
?- arc_clause2graph_term(Graph).
Graph = digraph([m, p, q], [a(m, q, 7), a(p, q, 9), a(p, m, 5)]) .

?- arc_clauses(Arcs), arc_clause_list2graph_term(Arcs, Graph).
Arcs = [arc(m, q, 7), arc(p, q, 9), arc(p, m, 5)],
Graph = digraph([m, p, q], [a(m, q, 7), a(p, q, 9), a(p, m, 5)]) .

... but ...

?- Graph = digraph([m, p, q], [a(m, q, 7), a(p, q, 9), a(p, m, 5)]), 
   arc_clause_list2graph_term(Arcs, Graph).

does not terminate.
*/


