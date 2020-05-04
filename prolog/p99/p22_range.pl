/*
P22 (*) Create a list containing all integers within a given range.

Example:

?- range(4,9,L).
L = [4,5,6,7,8,9]
*/

range(A,B,[]) :-
   A > B.
range(A,B,[A|Ans]) :-
   A =< B,
   C is A + 1,
   range(C,B,Ans).

/* moving range/3 to utils/list-library. */
