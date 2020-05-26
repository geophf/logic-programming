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
