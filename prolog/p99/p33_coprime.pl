/*
P33 (*) Determine whether two positive integer numbers are coprime.
Two numbers are coprime if their greatest common divisor equals 1.

Example:

?- coprime(35, 64).
Yes
*/

:- ['utils/math'].

coprime(A, B) :- gcd(A, B, 1).
