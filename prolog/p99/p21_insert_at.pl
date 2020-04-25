insert_at(Elt,T,1,[Elt|T]).
insert_at(Elt,[H|T],N,[H|L]) :-
   N > 1,
   M is N - 1,
   insert_at(Elt,T,M,L).
