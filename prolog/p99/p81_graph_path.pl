/*
P81 (**) Path from one node to another one

Write a predicate path(G,A,B,P) to find an acyclic path P from node A to node b 
in the graph G. The predicate should return all paths via backtracking.
*/

% Let's use the directed graph from problem 80.

:- ['p99/p80_graph_conversions_2_directed'].

:- ['utils/list'].
:- ['utils/cat'].

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

/*
?- arc_clause2graph_term(Gr),                                                   graph_path(Gr, s, r, Path).
Path = [a(s, u), a(u, r)] ;
Path = [a(s, u), a(u, s), a(s, r)] .

?- arc_clause2graph_term(Gr),                                                   
   graph_path(Gr, v, r, Path).
Path = [a(v, u), a(u, r)] ;
Path = [a(v, u), a(u, s), a(s, r)] ;
no.

The above algorithm allows a single cycle:

?- arc_clause2graph_term(Gr),                                                   graph_path(Gr, u, r, Path).
Path = [a(u, r)] ;
Path = [a(u, s), a(s, u), a(u, r)] ;
Path = [a(u, s), a(s, r)] ;
no.

... but doesn't allow n-cycles for n > 1.

We ... COULD get jiggy wid it, and delete cycle-back arcs, or we could
allow this, as it does return, given the nature of delete is monotonically
decreasing the available arcs at each hop.
*/
