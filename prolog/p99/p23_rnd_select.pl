:- [p20_remove_at].

rnd_select(_,0,[]).
rnd_select(List,N,[Elt|Ans]) :-
   N > 0,
   M is N - 1,
   random(X),
   length(List,Len),
   mod(X,Len,Idx),
   Baised1 is Idx + 1,
   remove_at(Elt,List,Baised1,L),
   rnd_select(L,M,Ans).
