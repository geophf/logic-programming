/*
P31 (**) Determine whether a given integer number is prime.

Example:

?- is_prime(7).
Yes
*/

/*

From:

https://primes.utm.edu/curios/includes/primetest.php?input=31

Yeah, whatever.


// The largest integer Java natively supports is 2^53-1, so these
// routines are designed to work for *positive* integers up to that.

// Currently the function check does the idiot proof to see only positive
// integers (not too large) are passed to the other routines.


// trial_divide(N,max) uses trial division to seek the smallest
// prime divisor of N, returns 0 if none found.

function trial_divide(N,max) {
  // Trial divides the positive integer N by the primes from 2 to max
  // Returns the first prime divisor found, or 0 if none found
  // Note: if N < max^2 is a prime, then N will be returned.
  if (N%2 == 0) return 2;
  if (N%3 == 0) return 3;
  // No need to go past the square root of our number
  var Stop = Math.min(Math.sqrt(N),max);
  // Okay, lets "wheel factor" alternately adding 2 and 4
  var di=2;
  for(i=5; i<=Stop; i+=di, di=6-di) {
    if (N%i == 0) return i;
  };
  if (N >= max*max) return 0;
  return N;
}

*/

trial_divide(N, Mod) :-
   mod(N, 2, X),
   (X = 0 -> Mod = 2 ; trial_divide3(N, Mod)).

trial_divide3(N, Mod) :-
   mod(N, 3, X),
   (X = 0 -> Mod = 3 ; trial_divide_start(N, Mod)).

trial_divide_start(N, Mod) :-
   sqrt(N, Stop),
   trial_divide_loop(N, 5, 2, Stop, Mod).

trial_divide_loop(N, I, DI, Stop, Mod) :-
   mod(N, I, X),
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

/* moving is_prime/1 to utils/math-library */
