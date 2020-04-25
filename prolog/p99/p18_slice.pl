slice([H|T],1,N,[H|List]) :-
   take(T,N,List).
slice([_|T],N,M,List) :-
   N > 1,
   N1 is N - 1,
   M1 is M - 1,
   slice(T,N1,M1,List).

take(_,1,[]).
take([H|T],N,[H|List]) :-
   N > 1,
   N1 is N - 1,
   take(T, N1, List).
