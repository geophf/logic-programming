/*
P36 (**) Determine the prime factors of a given positive integer (2).
Construct a list containing the prime factors and their multiplicity.

Example:

?- prime_factors_mult(315, L).
L = [[3,2],[5,1],[7,1]]

Hint: The problem is similar to problem P13.
*/

:- [p35_prime_factors].
:- ['utils/list'].

prime_factors_mult(N, Fs) :-
   prime_factors(N, F0s),
   encode(F0s, Fs).

/*
My approach:

?- prime_factors_mult(315, Fs).
Fs=[3-2,5-1,7-1]

... which is really a bag, and can also be achieved by a reduce on prime_factors
using avl_alter_f, but okay.
*/
