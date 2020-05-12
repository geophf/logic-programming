/*
Let's read from argv, or some such ... what does Prolog have for argv? and
then write to ... stdout? Yes.

The section, UNIX pseudo-executables, contains compiling-to-C instructions,
including:

or, for SWI-prolog, this:

https://www.swi-prolog.org/pldoc/man?section=compilation

$ swipl -o rr -c 00_readin_ritin.pl 

n.b.: ORDER IS IMPORTANT! first -o, THEN -c. Why? I don't know why.

./rr 123 4 5 2 1
Arguments are [123,4,5,2,1]

./rr "The quick, brown fox jumps over the lazy dog." and foo
Arguments are [The quick, brown fox jumps over the lazy dog.,and,foo]
*/

:- initialization(main, main).

main(X) :-
   write('Arguments are '),
   write(X),
   nl.
