/* --------------------------------------------------------------
 * p07_flatten.pl

P07 (**) Flatten a nested list structure.
Transform a list, possibly holding lists as elements into a `flat' list by 
replacing each list with its elements (recursively).

Example:
?- my_flatten([a, [b, [c, d], e]], X).
X = [a, b, c, d, e]

Hint: Use the predefined predicates is_list/1 and append/3

flatten([], []).
flatten([H|T], X) :-
  (is_list(H) -> flatten(H, Y); Y = [H]),
  flatten(T, Z), append(Y, Z, X).

Again, this algorithm is in double-linear, or more like m-by-n time. Let's
do something better with definite clause grammars.

Recall, that, since we're using difference lists, we work 'backward' to our
answer.

Also, I'm not saying that everywhere you're using append/3 that you should use
difference lists, otherwise you're doing it wrong, but ... yeah. This
"iteratively constructing a list with append/3" once bit me in production. It
worked for small lists in test, but when we moved beyond 1000s of element,
the delay, exponential, became unmanageable and the code had to be rewritten.
 */

flatten(Bumpy, Flat) :- flatten1(Bumpy, Flat, []).

flatten1([]) --> [].
flatten1([H|T]) -->
   { is_list(H) -> flatten(H, Y); Y = [H] },
   Y,
   flatten1(T).

is_list([]).
is_list([_|_]).
