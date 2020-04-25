:- [p23_rnd_select].
:- [p22_range].

lotto(Pick,N,Lotto) :-
   range(1,N,Nums),
   rnd_select(Nums,Pick,Lotto).
