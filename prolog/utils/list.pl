:- ['utils/cat'].

/* Some list routines */

head([H|_], H).
tail([_|T], T).

concat(Lists, List) :- concat1(Lists, List, []).

concat1([]) --> [].
concat1([H|T]) --> H, concat1(T).

repeat(0, _, []).
repeat(N, Elt,  [Elt|List]) :-
   N > 0,
   M is N - 1,
   repeat(M, Elt, List).

encode --> group, map(count).  /* head &&& length */

/* should be head &&& length: */
count([H|T], H - Len) :-
   length([H|T], Len).

group([], []).
group([H|T], [Hs|Y]) :-
   collect(H, T, Hs, Ts),
   group(Ts, Y).

collect(H, [], [H], []).
collect(H, [H|T], [H|Ans], Rest) :-
   collect(H, T, Ans, Rest).
collect(H, [X|T], [H], [X|T]) :-
   not(H = X).

take(_,0,[]).
take([H|T],N,[H|List]) :-
   N > 0,
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

range(A,B,[]) :-
   A > B.
range(A,B,[A|Ans]) :-
   A =< B,
   C is A + 1,
   range(C,B,Ans).

/* List predicates that take a functional-argument: */

reduce(_, Sum, [], Sum).
reduce(Pred2, Accum, [H|T], Sum) :-
   apply(Pred2, H, F0),
   apply(F0, Accum, F1),
   apply(F1, NewAccum, Fn),
   call(Fn),
   reduce(Pred2, NewAccum, T, Sum).

do(_, []).
do(Pred, [H|T]) :- call(Pred,H), do(Pred, T).

map(Pred, List, Mapped) :- map1(Pred, List, Mapped, []).

map1(_, []) --> [].
map1(Pred, [H|T]) -->
   { call(Pred, H, X) },
   [X],
   map1(Pred, T).

/*
e.g.:

?- map(length, [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]], Lens).
Lens=[3,2,3,2,4,2,1]

yes
*/

filter(Pred, List, Filtered) :- filter1(Pred, List, Filtered, []).

filter1(_, []) --> [].
filter1(Pred, [H|T]) -->
   { apply(Pred, H, Fn),
     call(Fn) -> Ans = [H]; Ans = [] },
   Ans,
   filter1(Pred, T).

partition(Fn, List, Ls, Rs) :-
   partition1(Fn, List, RevLs, [], RevRs, []),
   reverse(RevLs, Ls),  /* There may be a better way to do this than reversing 
                           at the end? */
   reverse(RevRs, Rs).

partition1(_, [], Ls, Ls, Rs, Rs).
partition1(Fn, [H|T], AnsLs, Ls, AnsRs, Rs) :-
   apply(Fn, H, Pred),
   (call(Pred) -> NewLs = [H|Ls], NewRs = Rs; NewLs = Ls, NewRs = [H|Rs]),
   partition1(Fn, T, AnsLs, NewLs, AnsRs, NewRs).

/* zip/3 zips two lists together, tupling the pairs */

zip(As, Bs, Cs) :- zip_with(tup, As, Bs, Cs).

/* zip_with/4 tells us how to zip two lists together (e.g. (+) adds pairs) */

zip_with(Fn, As, Bs, Cs) :- zip_with1(Fn, As, Bs, Cs, []).

zip_with1(_, [], _) --> [].
zip_with1(_, _, []) --> [].
zip_with1(Fn, [A|As], [B|Bs]) -->
   { call(Fn, A, B, C) },
   [C],
   zip_with1(Fn, As, Bs).

/* ... and some combinatorics */

/* pick(s) are (re)written in DCG-friendly-style */

delete(H, [H|T], T).
delete(P, [H|T], [H|L]) :-
   delete(P, T, L).
delete(_, [], []).   % the "element isn't here" is the don't-care case.

/* 
pickN(X, Picked, Domain, Range) is deleteList for ground Picked and free Range
*/

pickN(0, []) --> [].
pickN(N, [P|Ans]) -->
   { N > 0,
     M is N - 1 },
   delete(P),
   pickN(M, Ans).
