/*
Getting rid of that pesky is/2 clause :)
... by using that pesky is/2 clause :(
*/

:- ['utils/list'].    /* for encode/2 */

pred(N, P) :- minus(N, 1, P).
succ(A, S) :- plus(1, A, S).
plus(A, B, Sum) :- Sum is A + B.
minus(A, B, Difference) :- Difference is A - B.
multiply(A, B, Product) :- Product is A * B.

/* integer divide. caveat emptor */
divide(A, B, IntegerQuotient) :- IntegerQuotient is A // B. 

pow(N, P, Power) :- Power is N ** P.

/* Some number-theory stuff */

/* -------------------------- is_prime/1 --------------------------- */

trial_divide(N, Mod) :- 
   X is mod(N, 2),
   (X = 0 -> Mod = 2 ; trial_divide3(N, Mod)).

trial_divide3(N, Mod) :-
   X is mod(N, 3),
   (X = 0 -> Mod = 3 ; trial_divide_start(N, Mod)).

trial_divide_start(N, Mod) :-
   sqrt(N, Stop),
   trial_divide_loop(N, 5, 2, Stop, Mod).

trial_divide_loop(N, I, DI, Stop, Mod) :-
   X is mod(N, I),
   (X = 0 -> Mod = I ; trial_divide_cont(N, I, DI, Stop, Mod)).

trial_divide_cont(N, I, DI, Stop, Mod) :-
   NewI is I + DI,
   NewDI is 6 - DI,
   (NewI > Stop -> Mod = N ; trial_divide_loop(N, NewI, NewDI, Stop, Mod)).

/*
... talk about programming loops by continuations,* smh.

* continuation, n: computed GOTO.
*/

is_prime(N) :-
   trial_divide(N, N).

/* -------------------------- gcd/3 -------------------------------- */
/* Originally from p32_gcd.pl */

gcd(X, Y, G) :-
   not(X = Y),

/* first, let's order these by littlest and biggest: */

   (X > Y -> A = Y, B = X; A = X, B = Y),
   gcd1(A, B, 1, G).

gcd1(Littler, Bigger, Mod, G) :-
   X is mod(Littler, Mod),
   gcd2(Littler, X, Bigger, Mod, G).

gcd2(Littler, 0, Bigger, Mod, G) :-
   Div is Littler // Mod,  /* upper divisor */
   X is mod(Bigger, Div),
   div_check(Littler, Div, X, Bigger, Mod, G).
gcd2(Littler, X, Bigger, Mod, G) :-
   X > 0,
   cont(Littler, Bigger, Mod, G).

div_check(_, Div, 0, _, _, Div).
div_check(Littler, _, X, Bigger, Mod, G) :-
   X > 0,
   cont(Littler, Bigger, Mod, G).

cont(Littler, Bigger, Mod, G) :-
   M is Mod + 1,
   (M =< Littler -> gcd1(Littler, Bigger, M, G) ; G = 1).

/* ------------------------ coprime/2 ----------------------------- */

coprime(A, B) :- gcd(A, B, 1).

/* ... ooooooh! Hard one! */

/* -------------------- toitent function stuff -------------------- */

prime_factors(N, Fs) :-
   primes_to_sqrt(N, Primes),
   add_factors(N, Primes, Fs, []).

add_factors(1, _) --> [].
add_factors(N, _) -->
   { is_prime(N) },
   [N].
add_factors(N, [P|Primes]) -->
   { N > 1,
     Mod is mod(N, P),
     N1 is N // P },
   add_factor(N, N1, N2, Mod, P, Primes, Ps),
   add_factors(N2, Ps).

add_factor(_, N1, N1, 0, P, Primes, [P|Primes]) --> [P].
add_factor(N, _, N, X, _, Primes, Primes) --> { X > 0 }.

primes_to_sqrt(N, [2|[3|Ps]]) :-
   sqrt(N, Sqrt),
   loop(3, Sqrt, Ps).

loop(X, N, []) :-
   X > N.
loop(X, N, [P|Ps]) :-
   X =< N,
   next_prime(X, P),
   loop(P, N, Ps).

next_prime(P, P1) :- 
   P0 is P + 2,
   (is_prime(P0) -> P1 = P0 ; next_prime(P0, P1)).

prime_factors_mult(N, Fs) :-
   prime_factors(N, F0s),
   encode(F0s, Fs).
