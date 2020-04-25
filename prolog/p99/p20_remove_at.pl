remove_at(H,[H|T],1,T).
remove_at(X,[H|T],N,[H|L]) :-
   N > 1,
   M is N - 1,
   remove_at(X,T,M,L).
