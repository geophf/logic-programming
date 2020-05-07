/*
P38 (*) Compare the two methods of calculating Euler's totient function.

Use the solutions of problems P34 and P37 to compare the algorithms. Take the 
number of logical inferences as a measure for efficiency. Try to calculate 
phi(10090) as an example.
*/

:- ['p99/p34_toitent'].
:- ['p99/p37_toitent_improved'].

/* from p37_toitent_improved:

?- time(phi(10090, Phi)).
% 1,004 inferences, 0.000 CPU in 0.000 seconds (69% CPU, 4148760 Lips)
Phi = 4032 

* from p34_toitent:

?- time(toitent_phi(10090, Phi)).
% 192,792,273 inferences, 15.074 CPU in 15.201 seconds (99% CPU, 12789861 Lips)
Phi = 4032 

So, the improved function is not only faster, it's exponentially faster!
*/

hello(world).
