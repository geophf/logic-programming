pack([], []).
pack([H|T], [Hs|Y]) :-
   collect(H, T, Hs, Ts),
   pack(Ts, Y).

collect(H, [], [H], []).
collect(H, [H|T], [H|Ans], Rest) :-
   collect(H, T, Ans, Rest).
collect(H, [X|T], [H], [X|T]) :-
   not H = X.
