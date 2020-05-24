/*
P70 (**) Tree construction from a node string

We suppose that the nodes of a multiway tree contain single characters. In the 
depth-first order sequence of its nodes, a special character ^ has been 
inserted whenever, during the tree traversal, the move is a backtrack to the 
previous level.

By this rule, the tree in the figure below is represented as: afg^^c^bd^e^^^

Define the syntax of the string and write a predicate tree(String,Tree) to 
construct the Tree when the String is given. Work with atoms (instead of 
strings). Make your predicate work in both directions. [ed: no]

    (a)
   / | \
(f) (c) (b)
 |     /   \
(g) (d)     (e)

tree(Atom, t(H, Nodes)) :-
   name(Atom, [H|T]),
   parse_tree(T, Nodes)

No, I've got it. The (^) operator is very stack-y. So we'll pass in the
tree being worked on as history, the most recent tree being at the top of
the stack.

Now, [H|T] is a LIFO ('last in/first out') stack, so ... we're done.

Also, "^" is [94]
*/

:- ['library/tree'].

carat(94).

tree(Atom, Tree) :-
   name(Atom, [H|T]),
   name(A, [H]),
   tree_string(T, [t(A, [])], Tree).

tree_string([], [Tree], Tree). % ... should be at the top of the stack now.
tree_string([H|T], Trees, Tree) :-
   carat(H) ->
      pop_n_go(T, Trees, Tree)
   ;
      name(A, [H]),
      tree_string(T, [t(A, [])|Trees], Tree).

pop_n_go([], [Tree], Tree).
pop_n_go(Str, [T|[t(A, Kids)|Trees]], Tree) :-
   tree_string(Str, [t(A, [T|Kids])|Trees], Tree).

/*
So:

?- tree('afg^^c^bd^e^^^', Tree), ppt(Tree).
Tree=t(a,[t(b,[t(e,[]),t(d,[])]),t(c,[]),t(f,[t(g,[])])])

                                   t
                                   |
            .------------------------.
            |                        |
            a                        .
                                     |
                        .----------------------.
                        |                      |
                        t                      .
                        |                      |
               .----------.           .------------.
               |          |           |            |
               b          .           t            .
                          |           |            |
                    .--------.      .---.        .--------.
                    |        |      |   |        |        |
                    t        .      c  []        t       []
                    |        |                   |         
                  .---.    .-----.         .------.
                  |   |    |     |         |      |
                  e  []    t    []         f      .
                           |                      |
                         .---.                  .-----.
                         |   |                  |     |
                         d  []                  t    []
                                                |      
                                              .---.
                                              |   |
                                              g  []
*/
