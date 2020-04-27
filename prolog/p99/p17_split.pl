/*
P17 (*) Split a list into two parts; the length of the first part is given.
Do not use any predefined predicates.

Example:

?- split([a,b,c,d,e,f,g,h,i,k],3,L1,L2).
L1 = [a,b,c]
L2 = [d,e,f,g,h,i,k]
*/

split(List,0,[],List).
split([H|T],N,[H|Frist],Secnod) :-
   N > 0,
   M is N - 1,
   split(T,M,Frist,Secnod).
