% some ease-of-readin'-and-ritin' predicates

/*
writsp/1 for writing space-separated terms, instead of format.

usage:

   do(writsp, ['Processed', Len, films]), nl, nl.
*/

writsp(T) :- write(T), sp.

/*
write_term/1 ... because we want to write terms.

usage:

   do(write_term, Terms), nl,

to write out, e.g.: a fact-table.
*/

write_term(T) :- print(T), full_stop.

/* n.b.: write_term/1 is prolog-implementation-dependent. write_term/1 in SWI 
         works for SWI-only! (the ('') verses (\') issue.
*/

/* some stuphfen */

sp :- write(' ').
full_stop :- write('.'), nl.
