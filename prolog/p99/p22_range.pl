range(A,B,[]) :-
   A > B.
range(A,B,[A|Ans]) :-
   A =< B,
   C is A + 1,
   range(C,B,Ans).
