/*
Graph-to-cypher conversion predicates
*/

:- ['utils/list'].
:- ['utils/cat'].
:- ['utils/str'].

/*
We use the graph-term form to translate between the graph store and Prolog.
*/

materialize_cyphers(Graph) -->
   { unpair(Graph, Nodes, Edges),
     map(create_node, Nodes, N1),
     map(merge_relation, Edges, E1) },
   N1,
   E1.

% converts Term of form t(l1(a), l2(b), ..., ln(z)) to a neo4j node
%    where t is the type and l1, ... ln are the labels for the data a, b, ... z

node(Var, Term, Node) :-
   Term =.. [Type|SubTerms],
   atom_string(Var, V),
   capitalize_atom2str(Type, Label),
   map(term2attrib, SubTerms, Attribs),
   list_str_with("{}", Attribs, AttribList),
   str_cat(["(", V, ":", Label, " ", AttribList, " )"], Node).

term2attrib(Term, Attrib) :-
   Term =.. [Fn, Arg],
   val(Arg, Val),
   atom_string(Fn, Label),
   str_cat([Label, ": ", Val], Attrib).

val(Val, Str) :-
   number(Val) ->
     number_string(Val, Str)
   ;
     str_cat(["\"", Val, "\""], Str).

create_node(Term, Stmt) :-
   node(a, Term, Node),
   str_cat(["CREATE ", Node, "; "], Stmt).

match_node(Var, Term, Stmt) :-
   node(Var, Term, Node),
   str_cat(["MATCH ", Node, " "], Stmt).
   
node_ref(A, Ref) :-
   list_str_with("()", [A], Ref).

rel(A, Rel, B, Relation) :-
   node_ref(A, ARef),
   node_ref(B, BRef),
   atom_string(Rel, RelStr),
   str_cats([ARef, "-[:", RelStr, "]->", BRef], Relation).

merge_relation(Type, Edge, Stmt) :-
   unpair(Edge, A, B),
   match_node(a, A, MatchA),
   match_node(b, B, MatchB),
   rel(a, Type, b, Rel),
   str_cat([MatchA, MatchB, "MERGE ", Rel, "; "], Stmt).
