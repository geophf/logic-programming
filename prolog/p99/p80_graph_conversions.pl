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

/*
?- edges(Edges), all_nodes(Edges, Nodes).
Edges=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)],
Nodes=[b,c,d,f,g,h,k]

yes
*/

de_edge(edge(A, B), [A-A, B-B]).

remove_idem_edges(Edges, NonDups) :-
   rie(Edges, NonDups, []).

rie([]) --> [].
rie([H|T]) -->
   ({ H = edge(X, X) } ->
       []
    ;
       [H]),
   rie(T).

/*
?- edges(Edges), remove_idem_edges(Edges, NonDups).
Edges=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c),edge(d,d)],
NonDups=[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c)]

yes
*/

edge_clause2graph_term(graph(Nodes, Edges)) :-
   edges(E0),
   all_nodes(E0, Nodes),

   % now we can remove the edge(d,d) or we can keep it. 
   % The graph form removes it.

   remove_idem_edges(E0, Edges).

/*
?- edge_clause2graph_term(Graph).
Graph=graph([b,c,d,f,g,h,k],[edge(h,g),edge(k,f),edge(f,b),edge(f,c),edge(b,c)])

yes
*/
