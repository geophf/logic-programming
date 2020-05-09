/*
P46 (**) Truth tables for logical expressions.

Define predicates and/2, or/2, nand/2, nor/2, xor/2, impl/2 and equ/2 (for 
logical equivalence) which succeed or fail according to the result of their 
respective operations; e.g. and(A,B) will succeed, if and only if both A and B 
succeed. Note that A and B can be Prolog goals (not only the constants true and 
fail).

A logical expression in two variables can then be written in prefix notation, 
as in the following example: and(or(A,B),nand(A,B)).

Now, write a predicate table/3 which prints the truth table of a given logical 
expression in two variables.

Example:

?- table(A,B,and(A,or(A,B))).
true true true
true fail true
fail true fail
fail fail fail
*/

:- ['library/tree'].

% and(P, Q) :- P, Q.   % already defined
% or(P, Q) :- P ; Q.   % already defined

nor(P, Q) :- not(P), not(Q).
xor(P, Q) :- P -> not(Q) ; Q.
equ(P, P).

table(P, Q, Expression) :- 
   println('P    Q    Ans'),
   println('--------------'),
   tabled(P, Q, Expression).

tabled(P, Q, Expression) :-
   TF = [true, fail],
   member(P, TF),
   member(Q, TF),
   (Expression -> Ans = true; Ans = fail),
   print_list([P, Q, Ans]),
   fail.

% println(Obj) :- print(Obj), nl.

print_list([]) :- nl.
print_list([H|T]) :- print(H), sp, print_list(T).

sp :- print(' ').

/*
Here's something your logic engine could use: proof diagrams.

Since every proof in #Prolog is a tree, proof diagrams come ... FO' FREE!  
#Logic #DataStructures #DataAsPrograms #ProgramsAsData 

?- ppt(and(A,or(A,B))).
                                   and
                                    |
                                .-----.
                                |     |
                               V0    or
                                      |
                                    .---.
                                    |   |
                                   V0  V1
A='V0',
B='V1'

yes

Now: prove by elimination that and(A, or(A, B)) is simply A.
*/
