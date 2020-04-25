:- [list].

combination(0,_,[]).
combination(N,List,[Elt|Combination]) :-
   N > 0,
   length(List,Len),
   Len >= N,
   M is N - 1,
   pick1(Elt,List,L),
   combination(M,L,Combination).
