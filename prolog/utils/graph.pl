/*
Some common graph utilities...
*/

:- ['utils/cat'].

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
