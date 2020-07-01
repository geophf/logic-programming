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

% ------------------------------------------------------------- PATHING -----

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
   snd(Graph, Arcs),
   delete_arc(fst, A, Arc1, Arcs, Arcs0),
   (snd(Arc1, B) ->
       Path = [Arc1]
   ;
       delete_arc(snd, B, Brc1, Arcs0, Arcs1),
       gp1(Arcs1, Arc1, Brc1, Path)).

gp1(Arcs, Arc1, Brc1, Path) :-
    fst(Brc1, B1),
    snd(Arc1, A1),
    (A1 = B1 ->
       Path = [Arc1, Brc1]
    ;
       graph_path(digraph([], Arcs), A1, B1, Path1),
       append([Arc1|Path1], [Brc1], Path)).

delete_arc(Fn, A, Arc, [Ar|Cs], Rest) :-
    call(Fn, Ar, A),
    Arc = Ar,
    Rest = Cs.
delete_arc(Fn, A, Arc, [Ar|Cs], [Ar|Rest]) :-
    delete_arc(Fn, A, Arc, Cs, Rest).
