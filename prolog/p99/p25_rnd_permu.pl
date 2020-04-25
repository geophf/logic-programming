:- [p23_rnd_select].

rnd_permu(List,L) :-
   length(List,Len),
   rnd_select(List,Len,L).
