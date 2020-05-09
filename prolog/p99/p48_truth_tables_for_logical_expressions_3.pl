/*
P48 (**) Truth tables for logical expressions (3).

Generalize problem P47 in such a way that the logical expression may contain 
any number of logical variables. Define table/2 in a way that table(List,Expr) 
prints the truth table for the expression Expr, which contains the logical 
variables enumerated in List.

Example:

?- table([A,B,C], A and (B or C) equ A and B or A and C).
true true true true
true true fail true
true fail true true
true fail fail true
fail true true true
fail true fail true
fail fail true true
fail fail fail true
*/

:- op(500, yfx, and).
:- op(505, yfx, or).
:- op(450, fx, not).
:- op(515, xfx, equ).

:- [p46_truth_tables_for_logical_expressions_1].

truth_table(Vars, Expr) :-
   print_heading(Vars),
   tabled(Vars, Expr).

/*
Proof diagrams work even with infix operators declared with op/3:

?- ppt(A and (A or not B)).
                                  and
                                   |
                               .-----.
                               |     |
                              V0    or
                                     |
                                   .---.
                                   |   |
                                  V0  not
                                       |
                                       .
                                       |
                                      V1
A='V0',
B='V1'

yes
*/

