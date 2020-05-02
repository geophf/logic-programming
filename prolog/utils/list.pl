/* Some list routines */

repeat(0, _, []).
repeat(N, Elt,  [Elt|List]) :-
   N > 0,
   M is N - 1,
   repeat(M, Elt, List).

take(_,1,[]).
take([H|T],N,[H|List]) :-
   N > 1,
   N1 is N - 1,
   take(T, N1, List).

flatten(Bumpy, Flat) :- flatten1(Bumpy, Flat, []).

flatten1([]) --> [].
flatten1([H|T]) -->
   { is_list(H) -> flatten(H, Y); Y = [H] },
   Y,
   flatten1(T).

is_list([]).
is_list([_|_]).

/* ... and some combinatorics */

/* pick(s) are (re)written in DCG-friendly-style */

pick1(H, [H|T], T).
pick1(P, [H|T], [H|L]) :-
   pick1(P, T, L).

pickN(0, []) --> [].
pickN(N, [P|Ans]) -->
   { N > 0,
     M is N - 1 },
   pick1(P),
   pickN(M, Ans).
