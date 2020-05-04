/*
P34 (**) Calculate Euler's totient function phi(m).

Euler's so-called totient function phi(m) is defined as the number of positive 
integers r (1 <= r < m) that are coprime to m.

Example: m = 10: r = 1,3,7,9; thus phi(m) = 4. 
Note the special case: phi(1) = 1.

?- Phi is totient_phi(10).
Phi = 4

Find out what the value of phi(m) is if m is a prime number. Euler's totient 
function plays an important role in one of the most widely used public key 
cryptography methods (RSA). In this exercise you should use the most primitive 
method to calculate this function (there are smarter ways that we shall discuss 
later).
*/

:- ['utils/list'].
:- ['utils/math'].

toitent_phi(N, Count) :-
   M is N - 1,
   range(1, M, Domain),
   filter(coprime(N), Domain, Range),
   length(Range, Count).

is(X, toitent_phi(N)) :- toitent_phi(N, X).

/*
?- range(2,100,R), filter(is_prime,R,P), map(toitent_phi,P,Ts).
R=[2,3,4,5,6,7,8,9,10,...]
P=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97],
Ts=[1,2,4,6,10,12,16,18,22,28,30,36,40,42,46,52,58,60,66,70,72,78,82,88,96]

nToitents(P) = P - 1, or, proof:
*/

toitent_prime(P) :-
   is_prime(P),
   toitent_phi(P, X),
   Y is P - 1,
   X = Y.

/*
?- range(2,100,R), 
   filter(is_prime,R,P), 
   filter(toitent_prime, P, T), 
   P = T.

R=[2,3,4,5,6,7,8,9,10,...]
P=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97],
T=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97],
Pn=25,
Tn=25
*/
