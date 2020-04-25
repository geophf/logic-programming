:- [ps]. /* p04_len */
:- [p09_pack].

encode(List, X) :-
   pack(List, Y),
   encode1(Y, X).

encode1([], []).
encode1([H|T], [H1|T1]) :-
   count(H,H1),
   encode1(T,T1).

count([H|T], [Len,H]) :-
   len(Len, [H|T]).
