/*
Getting rid of that pesky is/2 clause :)
... by using that pesky is/2 clause :(
*/

succ(A, S) :- plus(1, A, S).
plus(A, B, Sum) :- Sum is A + B.
minus(A, B, Difference) :- Difference is A - B.
multiply(A, B, Product) :- Product is A * B.
divide(A, B, Quotient) :- Quotient is A / B.
