:- ['utils/list'].

/*
P15 (**) Duplicate the elements of a list a given number of times.

Example:

?- dupli([a,b,c],3,X).
X = [a,a,a,b,b,b,c,c,c]

What are the results of the goal:
?- dupli(X,3,Y).

dupli([],_,[]).
dupli([H|T],N,List) :-
   rep(H,N,Hs),
   dupli(T,N,Ts),
   append(Hs, Ts, List).

Let's use difference lists for dupli to avoid the append/3-mxn-list traversals.
*/

dupli(List,N,Ans) :- dupli1(List, N, Ans, []).

dupli1([],_) --> [].
dupli1([H|T],N) --> 
   { repeat(N,H,Hs) },
   Hs,
   dupli1(T,N).

/*
rep(_,0,[]).
rep(C,N,[C|List]) :-
   N > 0,
   M is N - 1,
   rep(C,M,List).
*/
