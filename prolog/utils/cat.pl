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
*/

/* a better apply. This one doesn't bind free variables */

apply(CurriedFn, Arg, FnArg) :-
   CurriedFn =.. List,
   append(List, [Arg], ListFn),
   FnArg =.. ListFn.

/*
compose(G, F, A0, A) :-
   call(G, A0, A1),
   apply(F, A1, A).
*/

/* ---------------------------------- tuples ----------------------------- */

fst(Term, Frist) :-
   Term =.. [_|[Frist|_]].

snd(Term, Secnod) :-
   Term =.. [_|[_|[Secnod|_]]].

dup(X, X - X).

/* ---------------------------------- Arrows ---------------------------- */

'&&&'(F, G, X - Y, FX - GY) :-
   apply(F, X, FX),
   apply(G, Y, GY).
