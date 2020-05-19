/*
p69_dot_string_not_dot_net

... (low blow, geophf. low. blow)

P69 (**) Dotstring representation of binary trees

We consider again binary trees with nodes that are identified by single 
lower-case letters, as in the example of problem P67. Such a tree can be 
represented by the preorder sequence of its nodes in which dots (.) are 
inserted where an empty subtree (nil) is encountered during the tree traversal. 
For example, the tree shown in problem P67 is represented as 'abd..e..c.fg...'. 
First, try to establish a syntax (BNF or syntax diagrams) and then write a 
predicate tree_dotstring/2 which does the conversion in both directions. Use 
difference lists.

BISH! I ATE YOUR DIFFERENCE LIST AND GROUND HIS BONES TO MAKE MY BREAD!

~ geophf, ... apparently a giant now, ... not an ogre. A giant.

Figure 1:

        (a)
       /   \
    (b)     (c)
   /   \       \
(d)     (e)     (f)
               /
            (g)
*/

:- ['utils/avl'].
:- ['utils/list'].
% :- ['p99/p68_preorder_inorder'].

/*

We have to build our own preordering that passes the tree-node structure
as well as the values.
*/

preorder(Tree, Seq) :-
   preorder1(Tree, Seq, []).

preorder1(t) --> [t].
preorder1(Tau) -->
   { Tau = t(_, _, L, R, _) },
   [Tau],
   preorder1(L),
   preorder1(R).

tree_dotstring(Tree, Atom) :-
   preorder(Tree, List),
   map(xlate, List, Strs),
   flatten(Strs, Str),
   name(Atom, Str).

% here's a ... reasonable(?) facsimile of the above tree?

abc(Tree) :-
   ABCs = [a,b,c,d,e,f],
   map(dup, ABCs, Dups),
   list_to_avl(Dups, Tree).

/*
... kinda balanced to:

        (d)
       /   \
    (b)     (e)
   /   \       \
(a)     (c)     (f)

... but whatever.
*/

/*
% so our DCG is rather simple, yes?

dotted(t) --> "."
dotted(t(K, V, L, R, _)) -->
   { name(K, Kstr),
     name(V, Vstr) },
   [Kstr],
   "-",
   [Vstr], ... then preorder-i-fy on this, but then that's intermixing
           ... data and algorithm

... but maybe a map-reduce over the predorder-result?

So, ...
*/

xlate(t, ".").
xlate(t(K, _V, _, _, _), KStr) :-
   name(K, KStr).

/*
   build_string_value(K, V, KVStr, "").

build_string_value(K, V) -->
   { name(K, KStr),
     name(V, VStr) },
   KStr,
   "-",
   VStr.
*/

/*
For our tree, abc/1, above, we have:

?- abc(Tree), tree_dotstring(Tree, Dots).
Tree=t(d,d,t(b,b,t(a,a,t,t,1),t(c,c,t,t,1),2),t(e,e,t,t(f,f,t,t,1),2),3),
Dots='dba..c..e.f..'

yes
*/
