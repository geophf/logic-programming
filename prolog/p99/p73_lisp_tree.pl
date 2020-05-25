/*
P73 (**) Lisp-like tree representation

There is a particular notation for multiway trees in Lisp. Lisp is a prominent 
functional programming language, which is used primarily for artificial 
intelligence problems. As such it is one of the main competitors of Prolog. In 
Lisp almost everything is a list, just as in Prolog everything is a term.

The following pictures show how multiway tree structures are represented in 
Lisp.

(a)       (a)        (a)           (b)                    (a)
           |          |           /   \                  / | \
          (b)        (b)       (d)     (e)            (f) (c) (b)
                      |                                |      / \
                     (c)                              (g)   (d) (e)


 a       (a b)     (a (b c))     (b d e)           (a (f g) c (b d e))

Note that in the "lispy" notation a node with successors (children) in the tree 
is always the first element in a list, followed by its children. The "lispy" 
representation of a multiway tree is a sequence of atoms and parentheses '(' 
and ')', which we shall collectively call "tokens". We can represent this 
sequence of tokens as a Prolog list; e.g. the lispy expression (a (b c)) could 
be represented as the Prolog list ['(', a, '(', b, c, ')', ')']. 

Write a predicate tree_ltl(T,LTL) which constructs the "lispy token list" LTL 
if the tree is given as term T in the usual Prolog notation.

Example:

?- tree_ltl(t(a,[t(b,[]),t(c,[])]),LTL).
LTL = ['(', a, '(', b, c, ')', ')']

As a second, even more interesting exercise try to rewrite tree_ltl/2 in a way 
that the inverse conversion is also possible: Given the list LTL, construct the 
Prolog tree T. Use difference lists.
*/

:- ['utils/io'].
:- ['utils/list'].

tree_ltl(Tree, List) :- lispy(Tree, List, []).

lispy(t(X, [])) --> [X].
lispy(t(X, [H|T])) -->
   ['(', X],
   lispy(H),
   lispums(T).

lispums([]) --> [')'].
lispums([H|T]) -->
   lispy(H),
   lispums(T).

/*
?- Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])]),
   tree_ltl(Tree, List).
List=['(',a,'(',b,e,d,')',c,'(',f,g,')',')']

yes

... and then:

?- tree_ltl(Tree, ['(',a,'(',b,e,d,')',c,'(',f,g,')',')']).
Tree=t(a,[t('(',[]),t(b,[]),t(e,[]),t(d,[]),t(')',[]),t(c,[]),t('(',[]),
          t(f,[]),t(g,[]),t(')',[])])

ummmm, ... well, anyway ... ^^)

... but then:
*/

lisp_list(Lispy) :- do(writsp, Lispy), nl.

/*
?- Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])]),
   tree_ltl(Tree, List), 
   lisp_list(List).
( a ( b e d ) c ( f g ) ) 
*/
