/*
P80 (***) Conversions

Write predicates to convert between the different graph representations. With 
these predicates, all representations are equivalent; i.e. for the following 
problems you can always pick freely the most convenient form. The reason this 
problem is rated (***) is not because it's particularly difficult, but because 
it's a lot of work to deal with all the special cases.
*/

/* FRIST we need to get all the edges as a thing.

So, for the first example graph we have the edge-clause form as follows:
*/

:- ['utils/cat'].
:- ['utils/list'].
:- ['utils/avl'].
:- ['utils/graph'].
:- ['utils/neo4j'].
:- ['utils/io'].

edge(h,g).
edge(k,f).
edge(f,b).
edge(f,c).
edge(b,c).
edge(d,d). % because this baby's flying solo

edges(Edges) :- findall(Edge, (edge(A, B), Edge = edge(A, B)), Edges).

/*
?- edges(Edges).
Edges=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)]

yes

BOOM!
*/

% moving all_nodes/2 to utils/graph-library.
% generalizing and moving remove_idem_edges/2 to utils/graph-library.

edge_clause2graph_term(Graph) :-
   edges(Edges),
   edge_clause_list2graph_term(Edges, Graph).

edge_clause_list2graph_term(Edges, graph(Nodes, Edges1)) :-
   all_nodes(Edges, Nodes),

   % now we can remove the edge(d,d) or we can keep it. 
   % The graph form removes it.

   remove_idem_edges(Edges, E0),
   map(relabel_edge(e), E0, Edges1).

% generalizing and moving edge_to_e/2 to utils/graph-library as
% relabel_edge/3.

/*
?- edge_clause2graph_term(Graph).
Graph=graph([b,c,d,f,g,h,k],[e(h,g),e(k,f),e(f,b),e(f,c),e(b,c)])

yes

... backwards doesn't halt.
*/

% moved adjacent_nodes_to/3 to utils/graph

edge_clause2adjacency_list(Adjays) :-
   edges(Edges),
   edge_clause_list2adjaceny_list(Edges, Adjays).

edge_clause_list2adjaceny_list(Edges, Adjays) :-
   all_nodes(Edges, Nodes),
   remove_idem_edges(Edges, E1),
   map(adjacent_nodes_to(E1), Nodes, Adjays).

/*
?- edge_clause2adjacency_list(Adjs).
Adjs=[n(b,[f,c]),n(c,[f,b]),n(d,[]),n(f,[k,b,c]),n(g,[h]),n(h,[g]),n(k,[f])]

yes

... backwards doesn't halt.
*/

edge_clause2human_readable(Human) :-
   edges(Edges),
   edge_clause_list2human_readable(Edges, Human).

% moving edge_clause_list2human_readable/2 and detup_retup/2 to utils/graph

/*
?- edge_clause2human_readable(Human).
Human=[h-g,k-f,f-b,f-c,b-c,d];

Human=[h-g,k-f,f-b,f-c,b-c,d-d];

no

also:

?- edge_clause_list2human_readable(E, [h-g,k-f,f-b,f-c,b-c,d]).
E=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)]

yes

YAY!

So, with that, we can go from human_readable to graph_term thus:

?- edge_clause_list2human_readable(E, [h-g,k-f,f-b,f-c,b-c,d]), 
   edge_clause_list2graph_term(E, G).
E=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)],
G=graph([b,c,d,f,g,h,k],[e(h,g),e(k,f),e(f,b),e(f,c),e(b,c)])

Voilà.
*/

human_readable2graph_term(HR, G) :-
   edge_clause_list2human_readable(E, HR),
   edge_clause_list2graph_term(E, G).

/*
Going from graph_term to human_readable requires a bit more work, because
we need to go 'backwards' to the edge_clause_list form from graph_term.
*/

graph_term2edge_clause_list(Graph, Edges) :- g2e(Graph, Edges, []).

g2e(graph(Nodes, Edges)) -->
   map_n_delete(Edges, Nodes, RemainingNodes),
   mk_edges(RemainingNodes).

mk_edges([]) --> [].
mk_edges([H|T]) -->
   [edge(H, H)],
   mk_edges(T).

map_n_delete([], Ns, Ns) --> [].
map_n_delete([e(A, B)|T], Ns, Nodes) -->
   { delete(A, Ns, N0),
     delete(B, N0, N1) },
   [edge(A, B)],
   map_n_delete(T, N1, Nodes).

/*
?- graph_term2edge_clause_list(graph([b,c,d,f,g,h,k],
                                     [e(b,c),e(b,f),e(c,f),e(f,k),e(g,h)]),
                               Edges).
Edges=[edge(b,c),edge(b,f),edge(c,f),edge(f,k),edge(g,h),edge(d,d)]

yes

Woot!

And with that, we can go from graphs to human-readable form thusly:
*/

graph_term2human_readable(G, HR) :-
   graph_term2edge_clause_list(G, E),
   edge_clause_list2human_readable(E, HR).

/*
?- graph_term2human_readable(graph([b,c,d,f,g,h,k],
                                   [e(b,c),e(b,f),e(c,f),e(f,k),e(g,h)]), HR).
HR=[b-c,b-f,c-f,f-k,g-h,d-d]

yes

TADA! And that's the all ways conversions for the simple graph forms.
*/

/*
BONUS!

Model the above graph, and address the above questions, exporting the graph
to neo4j. Download the answers into Prolog.

First: we use the graph-term form to translate between the graph store and
Prolog.
*/

% moved upload_simple_graph/1 to utils/neo4j

% moved vertices/1, relations/1 and graph/1 to utils/neo4j
