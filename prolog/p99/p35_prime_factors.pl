/*
P35 (**) Determine the prime factors of a given positive integer.
Construct a flat list containing the prime factors in ascending order.

Example:

?- prime_factors(315, L).
L = [3,3,5,7]
*/

:- ['utils/math'].

prime_factors(N, Fs) :- 
   primes_to_sqrt(N, Primes),
   add_factors(N, Primes, Fs, []).

add_factors(1, _) --> [].
add_factors(N, _) -->
   { is_prime(N) },
   [N].
add_factors(N, [P|Primes]) -->
   { N > 1,
     mod(N, P, Mod),
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

/*
?- prime_factors(17, Fs).
Fs=[17]

yes
?- prime_factors(221, Fs).
Fs=[13,17]

yes
?- next_prime(221, P).
P=223

yes
?- prime_factors(223, Fs).
Fs=[223]

Oooooh, @_primes_:

?- next_prime(711181, P).
P=711187

... in subsecond time. #Prolog #Logic #NumberTheory
*/

/* Adding prime_factors/2, etc to utils/math-library. */
