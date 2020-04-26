/*
P13 (**) Run-length encoding of a list (direct solution).
Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem P09, but only count them. As in problem P11, simplify the result list by replacing the singleton terms [1,X] by X.

Example:
?- encode_direct([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
X = [[4,a],b,[2,c],[2,a],d,[4,e]]
*/

/*
nupe

Again, not going to participate in an exercise that intentionally commingles
disparate types because of the reason of ... which reason again? The uniform
type [n,sym] is perfectly find. We have computers with more than 4k RAM these
days, in case anybody missed that advancement in technology.
*/
