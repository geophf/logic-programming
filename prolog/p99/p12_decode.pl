decode([H|T], List) :-
   decode1(H, Hs),
   decode(T, Ts),
   append(Hs,Ts,List).
decode([], []).

decode1([0,_], []).
decode1([N,C], [C|List]) :-
   M is N - 1,
   decode1([M,C], List).
