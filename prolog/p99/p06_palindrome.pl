/* --------------------------------------------------------------
 * p06_palindrome.pl

P06 (*) Find out whether a list is a palindrome.
A palindrome can be read forward or backward; e.g. [x,a,m,a,x].
 */

:- [p05_rev].

palindrome(X) :- rev(X, X).
