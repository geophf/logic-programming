% the problem

% For my birthday, I'm thinking of a number, AB.

% Given P = sorted prime numbers, where P0 = 2, P1 = 3, ...
% and B ∈ P
% and P8 < AB < P21
% and A < B
% and Px + Py * Pz = AB
% and Px < Py < Pz
% and A ∈ { Px, Py, Pz } ∈ P
% and B ∉ { Px, Py, Pz }

% What is my age (AB)?
% What are Px, Py, Pz?

% computes my birthday using CLP (constraint logic programming) 
% and number theory.

% FRIST! My birthday, AB, is within prime_range/1

prime_range(29).
prime_range(31).
prime_range(37).
prime_range(41). 
prime_range(43).
prime_range(47).
prime_range(53).
% prime_range(57). 3 * 19 = 57
prime_range(59).
prime_range(61).
prime_range(67).
prime_range(71).
prime_range(73).
prime_range(79).

% SECNOD! A is a prime digit:

prime_digit(2).
prime_digit(3).
prime_digit(5).
prime_digit(7).

% THRID! B is a prime_digit > A (TECHnically:, A < B, ... whatevs)

b(A, B) :- prime_digit(B), B > A.

% FORTH! { Px, Py, Pz } is constrained by Px + Py * Pz where Px < Py < Pz
% which, via Number Theory, further constrains the range of { Px, Py, Pz }

% (because:
% * the least Px may be is 2
% which means
% * the least Py may be is 3
% which means
% * the greatest Pz may be is 1/3 max(prime_range/1) - 2

p_range(2).
p_range(3).
p_range(5).
p_range(7).
p_range(11).
p_range(13).
p_range(17).
p_range(19).
p_range(23).

% from that we get (much constrained) possibilities for { Px, Py, Pz }

ps(AB, Px, Py, Pz) :-
   p_range(Px),
   p_range(Py),
   Px < Py,
   p_range(Pz),
   Py < Pz,
   Ps is Px + Py * Pz,
   AB = Ps.

% FINNA! our formula for my b-day:

bday(AB, Px, Py, Pz) :-
   prime_digit(A),
   b(A, B),
   AB is A * 10 + B,
   AB > 29,
   AB < 79,
   ps(AB, Px, Py, Pz),
   isin(A, [Px, Py, Pz]),
   not(isin(B, [Px, Py, Pz])).

isin(_, []) :- fail.
isin(A, [H|T]) :- A = H; isin(A, T).
