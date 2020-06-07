% String utilities. Boo-ya!

:- ['utils/list'].

capitalize_str(Hay, Yay) :-
   string_codes(Hay, [H|Ay]),
   atom_codes(Huh, [H]),
   upcase_atom(Huh, J),
   atom_codes(J, [Y]),
   string_codes(Yay, [Y|Ay]).

capitalize_atom2str(Lower, Upper) :-
   atom_string(Lower, Str),
   capitalize_str(Str, Upper).

str_cat(Strings, String) :-
   reduce(rev_str_cat, "", Strings, String).

rev_str_cat(A, B, C) :- string_concat(B, A, C).

rev_str_cat_with(Str, A, B, C) :-
   string_concat(Str, A, Z),
   string_concat(B, Z, C).

str_cat_with(_, [], "").
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

words(Str, Words) :-
   string_codes(Str, Codes),
   ws(Codes, Words, []).

space(32).
space(C) :- C - 9 =< 4.
space(160).

/* ---- Helper predicates for words/2 ---- */

ws([]) --> [].
ws([C|Odes]) -->
   { next_word([C|Odes], Cs, Codes, []),
     string_codes(Word, Codes) },
   [Word],
   ws(Cs).

next_word([], []) --> [].
next_word([C|Odes], NewCodes) -->
   { space(C) } ->
      next_word(Odes, NewCodes)
   ;
      word([C|Odes], NewCodes).

word([], []) --> [].
word([C|Odes], NewCodes) -->
   { space(C) } ->
      { NewCodes = [C|Odes] }
   ;
      [C],
      word(Odes, NewCodes).
