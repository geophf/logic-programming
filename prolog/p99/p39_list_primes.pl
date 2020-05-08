/*
P39 (*) A list of prime numbers.

Given a range of integers by its lower and upper limit, construct a list of all 
prime numbers in that range.
*/

:- ['utils/list'].
:- ['utils/math'].

list_primes(Start, End, Primes) :-
   range(Start, End, Range),
   filter(is_prime, Range, Primes).

/*
?- list_primes(2, 100, Primes).
Primes=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]

moving this function to utils/math-library.
*/
