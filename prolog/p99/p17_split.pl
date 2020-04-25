split(List,0,[],List).
split([H|T],N,[H|Frist],Secnod) :-
   N > 0,
   M is N - 1,
   split(T,M,Frist,Secnod).
