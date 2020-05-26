:- op(1125, xfx, &&&).

/* categories for Prolog

apply(List, Pred) :-
   apply1(List, DecomposedList, []),
   Pred =.. DecomposedList.

apply1([]) --> [].
apply1([H|T]) -->
   { is_list(H) -> List = [H]; H =.. List },
   List,
   apply1(T).

Now. How do we do compose? 

compose(G, F, A0, A) :-
   call(G, A0, A1),
   apply(F, A1, A).
*/

/* a better apply. This one doesn't bind free variables */

apply(CurriedFn, Arg, FnArg) :-
   CurriedFn =.. List,
   append(List, [Arg], ListFn),
   FnArg =.. ListFn.

/* ---------------------------------- tuples ----------------------------- */

tup(Fst, Snd, Fst - Snd).

fst(Term, Frist) :-
   Term =.. [_|[Frist|_]].

snd(Term, Secnod) :-
   Term =.. [_|[_|[Secnod|_]]].

unpair(Term, Fst, Snd) :-  % ... logically-equivalent to fst &&& snd
   Term =.. [_|[Fst|[Snd|_]]].
   % ... but faster, because only one term-destruction ('destructuring,' smh).

dup(X, X - X).

/*
swap(X - Y, Y - X) is true... I think.
*/
swap(Term, Swapped) :-
   Term =.. [Fn|Args],
   swapm(Args, SwappedArgs),
   Swapped =.. [Fn|SwappedArgs].

swapm([A|[B|_]], [B, A]).

/* ---------------------------------- Arrows ---------------------------- */
 
/*
no, but trying:
'&&&'(F, G, X - Y, FX - GY) :-
   apply(F, X, FX),
   apply(G, Y, GY).
*/

/* --------------------------------- Comparators ------------------------ */

lt(V1, V2) :- V2 < V1.
gt(V1, V2) :- V2 > V1.
eq(V1, V1).
le(V1, V2) :- V2 =< V1.
ge(V1, V2) :- V2 >= V1.
