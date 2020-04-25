/* --------------------------------------------------------------

https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/

The original address of this page is: 

https://prof.ti.bfh.ch/hew1/informatik3/prolog/p-99/

P-99: Ninety-Nine Prolog Problems

werner.hett@bfh.ch or werner.hett@gmail.com

The purpose of this problem collection is to give you the opportunity to 
practice your skills in logic programming. Your goal should be to find the most 
elegant solution of the given problems. Efficiency is important, but logical 
clarity is even more crucial. Some of the (easy) problems can be trivially 
solved using built-in predicates. However, in these cases, you learn more if you
try to find your own solution.

Every predicate that you write should begin with a comment that describes the 
predicate in a declarative statement. Do not describe procedurally, what the 
predicate does, but write down a logical statement which includes the arguments 
of the predicate. You should also indicate the intended data types of the 
arguments and the allowed flow patterns.

The problems have different levels of difficulty. Those marked with a single 
asterisk (*) are easy. If you have successfully solved the preceeding problems 
you should be able to solve them within a few (say 15) minutes. Problems marked 
with two asterisks (**) are of intermediate difficulty. If you are a skilled 
Prolog programmer it shouldn't take you more than 30-90 minutes to solve them. 
Problems marked with three asterisks (***) are more difficult. You may need more
time (i.e. a few hours or more) to find a good solution.

Working with Prolog lists

A list is either empty or it is composed of a first element (head) and a tail, 
which is a list itself. In Prolog we represent the empty list by the atom [] and
a non-empty list by a term [H|T] where H denotes the head and T denotes the 
tail.

P01 (*) Find the last element of a list.
Example:
?- my_last(X,[a,b,c,d]).
X = d

*/

my_last(X, [X]).
my_last(X, [H|T]) :- my_last(X, T).


/* --------------------------------------------------------------
 * p02_zweitletztes_element.pl
 *
 * https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/
 *
 */

zweitletztes_element(_, []) :- fail.
zweitletztes_element(_, [_]) :- fail.
zweitletztes_element(X, [X, _]).
zweitletztes_element(X, [_|T]) :- zweitletztes_element(X, T).



/* --------------------------------------------------------------
 * p03_element_at.pl
 */

element_at(X, [X|_], 1).  /* 1-biased 1-based. */
element_at(X, [_|T], N) :-
   M is N - 1,
   element_at(X, T, M).


/* --------------------------------------------------------------
 * p04_len.pl
 */

len(0, []).
len(Y, [_|T]) :-
   len(X, T),
   Y is X + 1.


/* --------------------------------------------------------------
 * p05_rev.pl
 */

rev([], []).
rev(X, [H|T]) :-
  rev(Y, T),
  append(Y, [H], X).


/* --------------------------------------------------------------
 * p06_palindrome.pl
 */

/* :- [p05_rev]. */

palindrome(X) :- rev(X, X).


/* --------------------------------------------------------------
 * p07_flatten.pl
 */

flatten([], []).
flatten([H|T], X) :-
  (is_list(H) -> flatten(H, Y); Y = [H]),
  flatten(T, Z), append(Y, Z, X).

is_list([]).
is_list([_|_]).


/* --------------------------------------------------------------
 * p08_compress.pl
 */

compress([], []).
compress([H|T],[H|X]) :-
   skip(H, T, Z),
   compress(Z, X).

skip(_, [], []).
skip(X, [X|T], Z) :-
   skip(X, T, Z).
skip(X, [H|T], [H|T]) :-
   not H = X.
