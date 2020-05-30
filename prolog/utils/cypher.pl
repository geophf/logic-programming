/*
Graph-to-cypher conversion predicates
*/

:- ['utils/list'].
:- ['utils/cat'].

/*
We use the graph-term form to translate between the graph store and Prolog.
*/

materialize_cyphers(Graph) -->
   { unpair(Graph, Nodes, Edges),
     map(create_node, Nodes, N1),
     map(merge_relation, Edges, E1) },
   N1,
   E1.

node(Var, Label, Node) :-
   atom_string(Label, Name),
   atom_string(Var, V),
   str_cats(["(", V, ":Vertex { label: """, Name, """ })"], Node).

create_node(H, Stmt) :-
   node(a, H, Node),
   str_cats(["CREATE ", Node, "; "], Stmt).

match_node(Var, Label, Stmt) :-
   node(Var, Label, Node),
   str_cats(["MATCH ", Node, " "], Stmt).
   
node_ref(A, Ref) :-
   atom_string(A, ARef),
   str_cats(["(", ARef, ")"], Ref).

rev_str_cat(A, B, C) :- string_concat(B, A, C).

str_cats(Strings, String) :-
   reduce(rev_str_cat, "", Strings, String).

rel(A, Rel, B, Relation) :-
   node_ref(A, ARef),
   node_ref(B, BRef),
   atom_string(Rel, RelStr),
   str_cats([ARef, "-[:", RelStr, "]->", BRef], Relation).

merge_relation(Edge, Stmt) :-
   unpair(Edge, A, B),
   match_node(a, A, MatchA),
   match_node(b, B, MatchB),
   rel(a, 'EDGE', b, Rel),
   str_cats([MatchA, MatchB, "MERGE ", Rel, "; "], Stmt).
