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
   thunk(capitalize_atom2str, "()", Var, Term, Node).

thunk(Capitalizer, Brackets, Var, Term, Thunk) :-
   string_codes(Brackets, [L, R]),
   string_codes(LBr, [L]),
   string_codes(RBr, [R]),
   Term =.. [Type|SubTerms],
   atom_string(Var, V),
   CapFn =.. [Capitalizer, Type, Label],
   CapFn,
   map(term2attrib, SubTerms, Attribs),
   list_str_with("{}", Attribs, AttribList, nothing_on_empty),
   padded(AttribList, Padded),
   str_cat([LBr, V, ":", Label, Padded, RBr], Thunk).

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
   create_node1(Term, semicolon, Stmt).

create_node1(Term, Semiwhat, Stmt) :-
   (Semiwhat = semicolon -> Semi = ";" ; Semi = ""),
   node(a, Term, Node),
   str_cat(["CREATE ", Node, Semi, " "], Stmt).

match_node(Var, Term, Stmt) :-
   node(Var, Term, Node),
   str_cat(["MATCH ", Node, " "], Stmt).
   
node_ref(A, Ref) :-
   list_str_with("()", [A], Ref, _).

% Like node/3, rel/4 takes a term describing its attributes

rel(A, Rel, B, Relation) :-
   node_ref(A, ARef),
   node_ref(B, BRef),
   thunk(string_upper, "[]", r, Rel, RelStr),
   str_cat([ARef, "-", RelStr, "->", BRef], Relation).

merge_relation(Term, Edge, Stmt) :-
   unpair(Edge, A, B),
   match_node(a, A, MatchA),
   match_node(b, B, MatchB),
   rel(a, Term, b, Rel),
   str_cat([MatchA, MatchB, "MERGE ", Rel, "; "], Stmt).
