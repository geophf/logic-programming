/*
P40 (**) Goldbach's conjecture.

Goldbach's conjecture says that every positive even number greater than 2 is 
the sum of two prime numbers. Example: 28 = 5 + 23. It is one of the most 
famous facts in number theory that has not been proved to be correct in the 
general case. It has been numerically confirmed up to very large numbers (much 
larger than we can go with our Prolog system). Write a predicate to find the 
two prime numbers that sum up to a given even integer.

Example:

?- goldbach(28, L).
L = [5,23]
*/

:- ['utils/list'].
:- ['utils/math'].

goldbach(Even, [P, P1]) :-
   Halvsies is Even // 2,
   list_primes(3, Halvsies, Primes),
   delete(P, Primes, _),
   P1 is Even - P,
   is_prime(P1). % ... or member(P1, Primes), perhaps?

/*
?- goldbach(28, L).
L=[5,23]

?- goldbach(1234, L).
L=[3,1231]

yes
?- goldbach(123456, L).
L=[7,123449]
*/
