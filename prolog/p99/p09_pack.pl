/*
P09 (**) Pack consecutive duplicates of list elements into sublists.

If a list contains repeated elements they should be placed in separate sublists.

Example:

?- pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
*/

pack([], []).
pack([H|T], [Hs|Y]) :-
   collect(H, T, Hs, Ts),
   pack(Ts, Y).

collect(H, [], [H], []).
collect(H, [H|T], [H|Ans], Rest) :-
   collect(H, T, Ans, Rest).
collect(H, [X|T], [H], [X|T]) :-
   not H = X.

/* moving pack/2 to utils/list-library as group/2 */
