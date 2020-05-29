/*
Graph-to-cypher conversion predicates
*/

:- ['utils/list'].

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
   str_cats([ARef, "<-[:", RelStr, "]->", BRef], Relation).

merge_relation(e(A, B), Stmt) :-
   match_node(a, A, MatchA),
   match_node(b, B, MatchB),
   rel(a, 'EDGE', b, Rel),
   str_cats([MatchA, MatchB, "MERGE ", Rel, "; "], Stmt).
