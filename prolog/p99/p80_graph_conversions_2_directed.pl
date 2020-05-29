/*
p80, continued. Now we look at arc/2
*/

:- ['utils/graph'].

:- ['utils/list'].

arc(s,u).
arc(u,r).
arc(s,r).
arc(u,s).
arc(v,u).
arc(t,t).

arcs(Arcs) :- findall(Arc, (arc(A, B), Arc = arc(A, B)), Arcs).

/*
?- arcs(Arcs).
Arcs = [arc(s, u), arc(u, r), arc(s, r), arc(u, s), arc(v, u), arc(t, t)].
*/

arc_clause2graph_term(Graph) :-
   arcs(Arcs),
   arc_clause_list2graph_term(Arcs, Graph).

arc_clause_list2graph_term(Arcs, digraph(Nodes, Edges)) :-

/* OKAY!

A lot happened since we been here, like uploading data to a graph store on
the cloud and then downloading information from a simple graph on the cloud...

... what're we doing here, again??? ;)

... oh, yeah! GENERALIZING utils/graph! YUS! :D
*/

   all_nodes(Arcs, Nodes),

   % ... I think self-referencing nodes should be allowed in the digraph.

   map(relabel_edge(a), Arcs, Edges).

% ... but, technically, node (t) does NOT refer to itself, so we still have
% a problem (*turns face away from problem). THERE! IT GONE! ;)

/*
?- arc_clause2graph_term(Graph).
Graph = digraph([r,s,t,u,v], [a(s,u), a(u,r), a(s,r), a(u,s), a(v,u), a(t,t)]) .
*/


