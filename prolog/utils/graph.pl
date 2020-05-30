/*
Some common graph utilities...
*/

:- ['utils/cat'].
:- ['utils/avl'].

/* 
all_nodes/2

we convert the edges to nodes and in the conversion, return the set of nodes.
*/

all_nodes(Edges, Nodes) :-
   map(de_edge, Edges, Bumpy),
   flatten(Bumpy, Flat),
   list_to_avl(Flat, AVL),
   avl_to_list(AVL, Set),
   map(snd, Set, Nodes).

de_edge(Pair, [Fst - Fst, Snd - Snd]) :-
   unpair(Pair, Fst, Snd).

/*
?- edges(Edges), all_nodes(Edges, Nodes).
Edges=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)],
Nodes=[b,c,d,f,g,h,k]

yes
*/

/*
Removes any edges that self-identify a singleton node. Why? This is for
the graph-term representation that does not have node-self-referring edges.
*/

remove_idem_edges(Edges, NonDups) :-
   rie(Edges, NonDups, []).

rie([]) --> [].
rie([H|T]) -->
   ({ unpair(H, A, B), A = B } -> [] ; [H]),
   rie(T).

/*
?- edges(Edges), remove_idem_edges(Edges, NonDups).
Edges=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)],
NonDups=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c)]

yes
*/

relabel_edge(Fn, Edge, Term) :-
   unpair(Edge, A, B),
   Term =.. [Fn, A, B].

/* We collect nodes adjacent to some node, N, here. */

adjacent_nodes_to(Edges, Node, n(Node, Nexts)) :-
   ant(Edges, Node, Nexts, []).

ant([], _) --> [].
ant([Edge|Edges], N) -->
   { unpair(Edge, A, B) },
   ({ N = A, C = B ; N = B, C = A } -> [C] ; []),
   ant(Edges, N).

/*
?- edges(Edges), adjacent_nodes_to(Edges, b, Node).
Edges=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)],
Node=n(b,[f,c])

yes
*/

/* here we convert a graph to human_readable form */

edge_clause_list2human_readable(Edges, Human) :-
   map(detup_retup, Edges, Human).

detup_retup(Edge, HRForm) :-
   unpair(Edge, A, B),
   (A = B -> HRForm = A ; HRForm = A - B).
