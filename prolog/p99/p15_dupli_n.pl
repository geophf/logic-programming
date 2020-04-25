dupli([],_,[]).
dupli([H|T],N,List) :-
   rep(H,N,Hs),
   dupli(T,N,Ts),
   append(Hs, Ts, List).

rep(_,0,[]).
rep(C,N,[C|List]) :-
   N > 0,
   M is N - 1,
   rep(C,M,List).
