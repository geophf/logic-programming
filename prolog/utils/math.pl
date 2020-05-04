/*
Getting rid of that pesky is/2 clause :)
... by using that pesky is/2 clause :(
*/

succ(A, S) :- plus(1, A, S).
plus(A, B, Sum) :- Sum is A + B.
minus(A, B, Difference) :- Difference is A - B.
multiply(A, B, Product) :- Product is A * B.
divide(A, B, Quotient) :- Quotient is A / B.

/* Some number-theory stuff */

/* -------------------------- gcd/3 -------------------------------- */
/* Originally from p32_gcd.pl */

gcd(X, X, X).
gcd(X, Y, G) :-
   not X = Y,

/* first, let's order these by littlest and biggest: */

   (X > Y -> A = Y, B = X; A = X, B = Y),
   sqrt(A, Sqrt),
   gcd1(A, Sqrt, B, 1, G).

gcd1(Littler, Sqrt, Bigger, Mod, G) :-
   mod(Littler, Mod, X),
   gcd2(Littler, Sqrt, X, Bigger, Mod, G).

gcd2(Littler, Sqrt, 0, Bigger, Mod, G) :-
   Div is Littler // Mod,  /* upper divisor */
   mod(Bigger, Div, X),
   div_check(Littler, Sqrt, Div, X, Bigger, Mod, G).
gcd2(Littler, Sqrt, X, Bigger, Mod, G) :-
   X > 0,
   cont(Littler, Sqrt, Bigger, Mod, G).

div_check(_, _, Div, 0, _, _, Div).
div_check(Littler, Sqrt, _, X, Bigger, Mod, G) :-
   X > 0,
   cont(Littler, Sqrt, Bigger, Mod, G).

cont(Littler, Sqrt, Bigger, Mod, G) :-
   M is Mod + 1,
   (M < Sqrt -> gcd1(Littler, Sqrt, Bigger, M, G) ; G = 1).
