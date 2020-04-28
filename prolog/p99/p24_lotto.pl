:- [p23_rnd_select].
:- [p22_range].

/*
P24 (*) Lotto: Draw N different random numbers from the set 1..M.
The selected numbers shall be put into a result list.

Example:

?- lotto(6,49,L).
L = [23,1,17,33,21,37]

Hint: Combine the solutions of problems P22 and P23.
*/

lotto(Pick,N,Lotto) :-
   range(1,N,Nums),
   rnd_select(Nums,Pick,Lotto).
