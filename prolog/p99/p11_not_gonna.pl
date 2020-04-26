/*
P11 (*) Modified run-length encoding.
Modify the result of problem P10 in such a way that if an element has no 
duplicates it is simply copied into the result list. Only elements with 
duplicates are transferred as [N,E] terms.

Example:
?- encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[4,a],b,[2,c],[2,a],d,[4,e]]

I'm against having a list all of one type, except for ... huh? no reason at all.

... so I'm not doing it
*/
