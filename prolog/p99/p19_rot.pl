rotate(List,0,List).
rotate(List,N,X) :-
   N > 0,
   M is N - 1,
   rot1(List,Y),
   rotate(Y,M,X).
rotate(List,N,X) :-
   N < 0,
   M is N + 1,
   rot1(Y,List),
   rotate(Y,M,X).

rot1([H|T],List) :-
   append(T, [H], List).
