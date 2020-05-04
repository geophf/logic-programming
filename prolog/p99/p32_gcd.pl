/*
P32 (**) Determine the greatest common divisor of two positive integer numbers.
Use Euclid's algorithm.

Example:

?- gcd(36, 63, G).
G = 9
*/

/*
There are two thoughts here. One is to compute all the divisors, then choose
the max common one. That's one approach, and perhaps the most common one.

The other approach is to go from divisor to divisor and match on the highest
one, and then we're done. Sounds declarative. Let's give it a try!
*/

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
  

/*
Define gcd as an arithmetic function; so you can use it like this:

?- G is gcd(36,63).
G = 9
*/

is(Val, sqrt(X)) :- sqrt(X, Val).
is(Val, gcd(X, Y)) :- gcd(X, Y, Val).

/*
And with that, I've created my first two Prolog arithmetic functions:

?- G is gcd(36,63).
G=9
*/

/* moving gcd/3 to utils/math-library */
