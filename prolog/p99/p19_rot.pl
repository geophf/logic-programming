/*
P19 (**) Rotate a list N places to the left.

Examples:

?- rotate([a,b,c,d,e,f,g,h],3,X).
X = [d,e,f,g,h,a,b,c]

?- rotate([a,b,c,d,e,f,g,h],-2,X).
X = [g,h,a,b,c,d,e,f]

Hint: Use the predefined predicates length/2 and append/3, as well as the result
of problem P17.

[original code]

... the above is the original solution. CAN WE DO BETTER???

I tried the below, but NOPE!

rotate(List,0,List).
rotate(List,N,Ans) :- rotate1(N,List,Ans,List).

rotate1(0,_) --> [].
rotate1(N,[H|T]) -->
   { N > 0,
     M is N - 1 },
   rotate3(M,[H|T]).

rotate3(M,[H|T],Ans,_) :- rotate4(M,[H|T],Ans,[]).

rotate4(M,[H|T]) -->
   T,
   [H],
   rotate2(M).

rotate2(N,Ans,List) :- rotate(List,N,Ans).

Ugh. I got three of my list, rotated once, as the answer. So ... no?
*/

rotate(List,0,List).
rotate(List,N,X) :-
   N > 0,
   M is N - 1,
   rot1(List,Y),
   rotate(Y,M,X).
rotate(List,N,X) :-
   N < 0,
   M is N + 1,
   rot1(Y,List),
   rotate(Y,M,X).

rot1([H|T],List) :-
   append(T, [H], List).

/*
... so let's try to replace the append in rot1/2

rot1([H|T],List) :- rot2([H|T],List,[]).

rot2([H|T]) --> T, [H].

... no, this works for the positive rotation, but not for negate rotation.

BAH! We use append/3 now! :/
*/
