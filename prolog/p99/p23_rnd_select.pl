:- [p20_remove_at].

/*
P23 (**) Extract a given number of randomly selected elements from a list.
The selected items shall be put into a result list.

Example:

?- rnd_select([a,b,c,d,e,f,g,h],3,L).
L = [e,d,a]

Hint: Use the built-in random number generator random/2 and the result of 
problem P20.
*/

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
