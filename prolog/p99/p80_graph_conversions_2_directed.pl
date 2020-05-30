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

arc_clause2adjacency_list(List) :-

   % ummmmmm, ... I don't think there's any change here; just arcs vs edges.
   arcs(Arcs),

   % wait! Direction is important here. You can't go backward against the
   % arrow to go to a 'from'-node.

   arc_clause_list2adjaceny_list(Arcs, List).

arc_clause_list2adjaceny_list(Arcs, List) :-
   all_nodes(Arcs, Nodes),
   map(adjacent_arrows(Arcs), Nodes, List).

adjacent_arrows(Arcs, FromNode, n(FromNode, Adjays)) :-
   aa(Arcs, FromNode, Adjays, []).

aa([], _) --> [].
aa([arc(A, B)|Arcs], FromNode) -->
   ({ A = FromNode } -> [B] ; []),
   aa(Arcs, FromNode).

/*
?- arc_clause2adjacency_list(List).
List = [n(r, []), n(s, [u, r]), n(t, [t]), n(u, [r, s]), n(v, [u])] .
*/

/*
Okay, everything for human_readable is the same ... EXCEPT! ... and why are
you not as surprised as I want you to be? ... EXCEPT! that instead of 
directionless edges, we have arrows. We can generalize human_readable ...

OR! We can take the edge-results then modify those with a mapping.

HOW 'BOUT DEM APPLES???
*/

arc_clause2human_readable(Human) :-
   arcs(Arcs),
   edge_clause_list2human_readable(Arcs, Interim),
   map(dash2arrow, Interim, Human).

dash2arrow(Term, Turm) :-
   Term = A - B -> Turm = (A > B) ; Turm = Term.

/*
?- arc_clause2human_readable(Humans).
Humans = [s>u, u>r, s>r, u>s, v>u, t] .
*/

/*
And now we load this arc_term graph, or digraph, to the neo4j graph store.
*/

% TODO: do that.
