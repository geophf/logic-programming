/*
P47 (*) Truth tables for logical expressions (2).

Continue problem P46 by defining and/2, or/2, etc as being operators. This 
allows to write the logical expression in the more natural way, as in the 
example: A and (A or not B). Define operator precedence as usual; i.e. as in 
Java.

Example:

?- table(A,B, A and (A or not B)).
true true true
true fail true
fail true fail
fail fail fail

From the SWI manual on op/3 precedence:

https://www.swi-prolog.org/pldoc/man?predicate=op/3

500	yfx	+, -, /\, \/, xor

so:

*/

:- op(500, yfx, and).
:- op(505, yfx, or).
:- op(450, fx, not).

:- [p46_truth_tables_for_logical_expressions_1].

foo(bar).

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

