:- [p04_len].
:- [p09_pack].

/*
P10 (*) Run-length encoding of a list.
Use the result of problem P09 to implement the so-called run-length encoding 
data compression method. Consecutive duplicates of elements are encoded as 
terms [N,E] where N is the number of duplicates of the element E.

Example:

?- encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[4,a],[1,b],[2,c],[2,a],[1,d][4,e]]

encode(List, X) :-
   pack(List, Y),
   encode1(Y, X).

or, as a DCG:
*/

encode --> pack, encode1.

encode1([], []).
encode1([H|T], [H1|T1]) :-
   count(H,H1),
   encode1(T,T1).

count([H|T], [Len,H]) :-
   len(Len, [H|T]).
