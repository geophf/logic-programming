drop(List,N,Ans) :-
   drop1(List,N,N,Ans).

drop1([],_,_,[]).
drop1([_|T],N,X,Ans) :-
   X = 1,
   drop1(T,N,N,Ans).
drop1([H|T],N,X,[H|Ans]) :-
   X > 1,
   Y is X - 1,
   drop1(T,N,Y,Ans).
