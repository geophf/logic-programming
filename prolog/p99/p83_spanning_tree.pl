/*
P83 (**) Construct all spanning trees

Write a predicate s_tree(Graph,Tree) to construct (by backtracking) all 
spanning trees of a given graph. With this predicate, find out how many 
spanning trees there are for the graph depicted to the left. The data of this 
example graph can be found in the file p83.dat. When you have a correct 
solution for the s_tree/2 predicate, use it to define two other useful 
predicates: is_tree(Graph) and is_connected(Graph). 

Both are five-minutes tasks!
*/

/*
Okay, to write a spanning tree we need to know what a spanning tree is.

WIKIPEDIA TO THE RESCUE!

https://en.wikipedia.org/wiki/Spanning_tree

In the mathematical field of graph theory, a spanning tree T of an undirected 
graph G is a subgraph that is a tree which includes all of the vertices of G, 
with a minimum possible number of edges. In general, a graph may have several 
spanning trees, but a graph that is not connected will not contain a spanning 
tree (but see Spanning forests below). If all of the edges of G are also edges 
of a spanning tree T of G, then G is a tree and is identical to T (that is, a 
tree has a unique spanning tree and it is itself).
*/

:- ['utils/neo4j'].

:- ['p99/p80_graph_conversions_3_labelled'].

spanning_tree_graph(digraph([a,b,c,d,e,f,g,h], [
     e(a,b), e(a,d), e(b,c), e(b,e), e(c,e), e(d,e),
     e(d,f), e(d,g), e(e,h), e(f,g), e(g,h)])).

/*
Okay, there're the spanning trees of a graph and the minimum spanning tree for
the graph. We're solving the former here, not the latter (not for this problem,
anyway. :/
*/

spanning_tree(Gr, SpanningTree) :- true.
