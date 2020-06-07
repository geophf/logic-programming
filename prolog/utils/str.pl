% String utilities. Boo-ya!

:- ['utils/list'].

capitalize_str(Hay, Yay) :-
   string_codes(Hay, [H|Ay]),
   atom_codes(Huh, [H]),
   upcase_atom(Huh, J),
   atom_codes(J, [Y]),
   string_codes(Yay, [Y|Ay]).

capitalize_atom2str(Lower, Upper) :-
   atom_chars(Lower, Str),
   capitalize_str(Str, Upper).

str_cat(Strings, String) :-
   reduce(rev_str_cat, "", Strings, String).

rev_str_cat(A, B, C) :- string_concat(B, A, C).

rev_str_cat_with(Str, A, B, C) :-
   string_concat(Str, A, Z),
   string_concat(B, Z, C).

str_cat_with(Sep, [S|Trs], Str) :-
   reduce(rev_str_cat_with(Sep), S, Trs, Str).

list_str(List, String) :-
   list_str_with("[]", List, String).

list_str_with(Brackets, List, String) :-
   string_codes(Brackets, [L, R]),
   string_codes(LBr, [L]),
   string_codes(RBr, [R]),
   str_cat_with(", ", List, Lost),
   str_cat([LBr, Lost, RBr], String).
