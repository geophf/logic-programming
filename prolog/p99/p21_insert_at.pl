/*
P21 (*) Insert an element at a given position into a list.

Example:

?- insert_at(alfa,[a,b,c,d],2,L).
L = [a,alfa,b,c,d]
*/

insert_at(Elt,T,1,[Elt|T]).
insert_at(Elt,[H|T],N,[H|L]) :-
   N > 1,
   M is N - 1,
   insert_at(Elt,T,M,L).
