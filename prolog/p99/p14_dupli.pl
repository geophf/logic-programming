dupli([], []).
dupli([H|T], [H|[H|Ts]]) :-
   dupli(T, Ts).
