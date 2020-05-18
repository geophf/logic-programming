/*
P67 (**) A string representation of binary trees

Somebody represents binary trees as strings of the following type (see example 
opposite):

?- ppt(a(b(d,e),c(f(g)))).
                                   a
                                   |
                                  .---.
                                  |   |
                                  b   c
                                  |   |
                                .--.  .
                                |  |  |
                                d  e  f
                                      |
                                      .
                                      |
                                      g
yes

a(b(d,e),c(f(g)))

a) Write a Prolog predicate which generates this string representation, if the 
tree is given as usual (as nil or t(X,L,R) term). Then write a predicate which 
does this inverse; i.e. given the string representation, construct the tree in 
the usual form. Finally, combine the two predicates in a single predicate 
tree_string/2 which can be used in both directions.

For simplicity, suppose the information in the nodes is a single letter and 
there are no spaces in the string.

tree_string(Tree, Term) :-
   tree_string1(Tree, List, []),
   construct(Term, List).

the problem is this: how do I know term was a var, without using the extra-
logical var/1-predicate? I can say: atom(key(tree) and then recompose or ..

... hm. Can I do that?

*/

tree_string(Tree, Term) :-
   Tree = t(K, _, _),
   (atom(K) -> 
               tree_string1(Tree, List, []), 
               construct(Term, List)
   ;
               retree(Term, Tree)).

retree(Term, Tree) :-
   atom(Term) -> Tree = t(Term,t,t) ; retree1(Term, Tree).

retree1(Term, t(H, L, R)) :-
   Term =.. [H|T],
   map(retree, T, L0L),
   two_o_fy(L0L, [L, R]).

two_o_fy([X], [t, X]).
two_o_fy([X, Y], [X, Y]).

tree_string1(t) --> [].
tree_string1(t(K, L, R)) -->
   tree_string2(K, L, R).
/*
   { atom(K) } -> tree_string2(K, L, R) ; reconstruct(K).

reconstruct(K) -->
   { K =.. [Fn, L, R] },
   tree_string1(t(Fn, t(L, t, t), t(R, t, t))).
*/

tree_string2(K, L, R) -->
   [K],
   listofy(L),
   listofy(R).

listofy(Tree) -->
   { tree_string1(Tree, List, []) },
   [List].

/*
construct == =..
?- tree_string(t(a, t(b, t(c, t,t), t(d, t, t)), t(c, t, t(f, t(g, t, t), t))), Term).
Term=a([b,[c,[],[]],[d,[],[]]],[c,[],[f,[g,[],[]],[]]])

Hmmm, ... not quite there yet. Let's add:
*/

construct(Functor, [Functor, [], []]).
construct(Term, [Functor, [], SubList]) :-
   construct(Arg, SubList),
   Term =.. [Functor, Arg].
construct(Term, [Functor, SubList, []]) :-
   construct(Arg, SubList),
   Term =.. [Functor, Arg].
construct(Term, [Functor, L1, L2]) :-
   construct(T1, L1),
   construct(T2, L2),
   Term =.. [Functor, T1, T2].

/*
With constructor/2 above:

?- tree_string(t(a, t(b, t(c, t,t), t(d, t, t)), t(c, t, t(f, t(g, t, t), t))), Term).
Term=a(b(c,d),c(f(g)))

BOOM!

But now I get:

?- tree_string(T, a(b(c,d),c(f(g)))).

Arguments are not sufficiently instantiated

When I try to go the other way. Am I making this too complicated?

Nah, just instantiate both FRIST! then go from there with a decomposer-thingie.

... destructurer ... destructor ... delight (SKY ROCKETS IN FLIGHT!)

Okay, got us back to a steady state from the Tree to the term, and from the
term to the tree we get:

?- tree_string(T, a(b(c,d),c(f(g)))).
T=t(a(b(c,d),c(f(g))),t,t)

yes

We can work with this.
*/

/*
SOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO... after all tha' an' all tha' ...

?- tree_string(t(a, t(b, t(c, t,t), t(d, t, t)), t(c, t, t(f, t(g, t, t), t))), Term).
Term=a(b(c,d),c(f(g)))

and

?- tree_string(T, a(b(c,d),c(f(g)))).
T=t(a,t(b,t(c,t,t),t(d,t,t)),t(c,t,t(f,t,t(g,t,t))))

and

?- tree_string(t(a,t(b,t(c,t,t),t(d,t,t)),t(c,t,t(f,t,t(g,t,t)))), T).
T=a(b(c,d),c(f(g)))

and

?- tree_string(t(a,t(b,t(c,t,t),t(d,t,t)),t(c,t,t(f,t,t(g,t,t)))), a(b(c,d),c(f(g)))).
yes

It's Miller time!
*/

/*
b) Write the same predicate tree_string/2 using difference lists and a single 
predicate tree_dlist/2 which does the conversion between a tree and a 
difference list in both directions.

Yeah. Did that. Party on, Wayne! Party on, Garth!
*/
