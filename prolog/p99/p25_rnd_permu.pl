:- [p23_rnd_select].

/*
P25 (*) Generate a random permutation of the elements of a list.

Example:

?- rnd_permu([a,b,c,d,e,f],L).
L = [b,a,d,c,e,f]

Hint: Use the solution of problem P23.
*/

rnd_permu(List,L) :-
   length(List,Len),
   rnd_select(List,Len,L).
