/*
P12 (**) Decode a run-length encoded list.
Given a run-length code list generated as specified in problem P11. Construct 
its uncompressed version.

:- decode([[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]], D).
D=[a,a,a,a,b,c,c,a,a,d,e,e,e,e]

decode([H|T], List) :-
   decode1(H, Hs),
   decode(T, Ts),
   append(Hs,Ts,List).
decode([], []).

Again, we can use DCGs here to eliminate the double-traversal with append/3.

*/

decode(List, Answer) :- decode1(List, Answer, []).

decode1([]) --> [].
decode1([H|T]) -->
  { repeat(H, Hs) },
  Hs,
  decode1(T).

repeat([]).
repeat([0,_], []).
repeat([N,C], [C|List]) :-
   M is N - 1,
   repeat([M,C], List).
