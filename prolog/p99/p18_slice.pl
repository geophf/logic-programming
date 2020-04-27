:- ['utils/list'].

/*
P18 (**) Extract a slice from a list.

Given two indices, I and K, the slice is the list containing the elements 
between the I'th and K'th element of the original list (both limits included). 
Start counting the elements with 1.

Example:

?- slice([a,b,c,d,e,f,g,h,i,k],3,7,L).
X = [c,d,e,f,g]
*/

slice([H|T],1,N,[H|List]) :-
   take(T,N,List).
slice([_|T],N,M,List) :-
   N > 1,
   N1 is N - 1,
   M1 is M - 1,
   slice(T,N1,M1,List).
