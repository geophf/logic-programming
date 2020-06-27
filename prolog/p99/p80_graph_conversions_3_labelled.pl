:- ['utils/avl'].
:- ['utils/list'].
:- ['utils/cat'].
:- ['utils/cypher'].
:- ['utils/neo4j'].

:- ['p99/utils'].

labelled_graph_example(digraph([k,m,p,q],[a(m,q,7),a(p,m,5),a(p,q,9)])).

arc(m,q,7).
arc(p,q,9).
arc(p,m,5).
arc(k,k,0).

arc_clause2graph_term(Diagraph) :-
   arc_clauses(Arcs1),
   arc_clause_list_graph_term(Arcs1, Diagraph).

arc_clauses(Arcs) :-
   findall(Arc, (arc(A, B, L), Arc = arc(A, B, L)), Arcs).

arc_clause_list_graph_term(ArcClauses, Graph) :-
   var(ArcClauses) ->
      gt2acl(Graph, ArcClauses)
   ;
      acl2gt(ArcClauses, Graph).

gt2acl(digraph(_Nodes, Arcs), ArcClauses) :-
   map(a2arc, Arcs, ArcClauses).

a2arc(X, Y) :- arc2a(Y, X).

acl2gt(ArcClauses, digraph(Nodes, Arcs)) :-
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

does not terminate... until we add the var/1 test at the head of the new
arc_clause_list_graph_term/2 predicate:

?- Graph = digraph([m, p, q], [a(m, q, 7), a(p, q, 9), a(p, m, 5)]), 
   arc_clause_list_graph_term(Arcs, Graph).
Graph = digraph([m, p, q], [a(m, q, 7), a(p, q, 9), a(p, m, 5)]),
Arcs = [arc(m, q, 7), arc(p, q, 9), arc(p, m, 5)] .
*/

/*
I'm thinking for the graph-form - adjacency list transform function, we push
everything into an AVL tree then read from that to produce either?
*/

graph_form_adjacency_list(Graph, Adjac) :-
   var(Graph) ->
      al2gf(Adjac, Graph)
   ;
      gf2al(Graph, Adjac).

al2gf(Adjac, digraph(Nodes, Arcs)) :-
   map(fst, Adjac, Nodes),
   map(map_arc, Adjac, Arcs0),
   flatten(Arcs0, Arcs).

map_arc(n(N, List), Ans) :-
   map(arcify(N), List, Ans).

arcify(A, B/L, a(A, B, L)).

gf2al(digraph(Nodes, Arcs), Adjac) :-
   avl_empty(T0),
   reduce(adder, T0, Arcs, Tree),
   map(null_or_in(Tree), Nodes, Adjac).

adder(a(A, B, L), T0, T1) :-
   Val = B / L,
   avl_alter_f(T0, A, [Val], cons(Val), T1).

null_or_in(AVL, Key, n(Key, Val)) :-
   avl_get(AVL, Key, V0) ->
      Val = V0
   ;
      Val = [].

/*
I think the simplest translation from-to is graph-form - human-friendly form.
*/

graph_term_form_human_friendly_form(Graph, Human) :-
   var(Graph) ->
      h2g(Human, Graph)
   ;
      g2h(Graph, Human).

h2g(Human, digraph(Nodes, Arcs)) :-
   avl_empty(E),
   h2g1(Human, AVL, E, Arcs, []),
   avl_keys(AVL, Nodes).

h2g1([], A, A) --> [].
h2g1([H|T], AVL, Base) -->
   ({ H = (A>B/L) } ->
      { avl_add_all([A,B], Base, A1) },
      [a(A, B, L)]
   ;
      { avl_add(H, Base, A1) }),
   h2g1(T, AVL, A1).

g2h(digraph(Nodes, Arcs), Human) :-
   avl_empty(E),
   map(dup, Nodes, NNodes),
   list_to_avl(NNodes, AllNodes),
   reduce(add_arc, E, Arcs, ArcNodes),
   avl_set_difference(AllNodes, ArcNodes, SoloAVL),
   avl_keys(SoloAVL, SoloNodes),
   map1(arc_2_human, Arcs, Human, SoloNodes).

add_arc(a(A, B, _)) --> avl_add_all([A, B]).

arc_2_human(a(A, B, L), (A>B/L)).

% ------------------------------------------------------ BONIS ROUND! -----

% Let's upload this graph to our data store ... how much do we need to change?

graph_me_baybee(Graph) :-
   p99_data_store(DB),
   clear_graph(DB),
   marshall_statements(Graph, Stmts),
   store_graph(DB, Stmts),
   write('It is uploaded, baybee!'), nl.

marshall_statements(digraph(Nodes, Arcs), Stmts) :-
   map(tag_tag(node, name), Nodes, NNodes),
   map(create_my_rel, Arcs, CreateRels),
   map1(create_node, NNodes, Stmts, CreateRels).

tag_tag(Outer, Inner, Val, Tagged) :-
   tag(Inner, Val, In),
   tag(Outer, In, Tagged).

create_my_rel(a(A, B, L), Stmt) :-
   tag_tag(node, name, A, NodeA),
   tag_tag(node, name, B, NodeB),
   merge_relation(edge(distance(L)), NodeA - NodeB, Stmt).
