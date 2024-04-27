/* a set is a list of unique elements */

/* but what are value-hashes? and how do we get them? */

/* term_hash/2 */

/* ... and for a set we need a binary tree, which is P60? perhaps? ... well,
   starting with P55, at any rate ... */

set([], set([])).
set([H|T], set(Set)) :-
   filter(diff(H)
