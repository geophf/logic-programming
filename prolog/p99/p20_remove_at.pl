/*
P20 (*) Remove the K'th element from a list.

Example:

?- remove_at(X,[a,b,c,d],2,R).

X = b
R = [a,c,d]
*/

remove_at(H,[H|T],1,T).
remove_at(X,[H|T],N,[H|L]) :-
   N > 1,
   M is N - 1,
   remove_at(X,T,M,L).
