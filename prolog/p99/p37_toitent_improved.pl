/*
P37 (**) Calculate Euler's totient function phi(m) (improved).

See problem P34 for the definition of Euler's totient function. If the list of 
the prime factors of a number m is known in the form of problem P36 then the 
function phi(m) can be efficiently calculated as follows: 

Let [[p1,m1],[p2,m2],[p3,m3],...] be the list of prime factors (and their 
multiplicities) of a given number m. Then phi(m) can be calculated with the 
following formula:

phi(m) = (p1 - 1) * p1**(m1 - 1) * (p2 - 1) 
                  * p2**(m2 - 1) * (p3 - 1) 
                  * p3**(m3 - 1) * ...

Note that a**b stands for the b'th power of a.
*/

:- ['utils/math'].
:- ['utils/list'].

/*
OOH! I GET IT! ... GEDDIT???
*/

toitent_term(P-M, toitent_state(Product, PrevP - PrevM), ToitentState) :-
   pred(PrevM, M1),
   pred(P, P1),
   NewProduct is Product * (PrevP ** M1) * P1,
   ToitentState = toitent_state(NewProduct, P - M).

phi(N, Toitent) :- 
  prime_factors_mult(N, [P-M|Factors]),
  pred(P, P1),
  reduce(toitent_term, toitent_state(P1, P - M), Factors, 
         toitent_state(Toitent, _)).

/*
?- time(phi(10070, Phi)).
% 1,301 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 8673333 Lips)
Phi = 3744 .
*/
