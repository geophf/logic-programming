/*
P68 (**) Preorder and inorder sequences of binary trees

We consider binary trees with nodes that are identified by single lower-case 
letters, as in the example of problem P67.

a) Write predicates preorder/2 and inorder/2 that construct the preorder and 
inorder sequence of a given binary tree, respectively. The results should be 
atoms, e.g. 'abdecfg' for the preorder sequence of the example in problem P67.

/*

/*
Quick question: If a problem has 4 sub-parts, isn't it four problems? or nah?
#imponderables.

Okay, let's break this problem up into 4 problems, smh.

Also, for 'those' of you who don't know (... 'those' == 'me.'): from 

https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/

Depth First Traversals:
(a) Inorder (Left, Root, Right) : 4 2 5 1 3
(b) Preorder (Root, Left, Right) : 1 2 4 5 3
(c) Postorder (Left, Right, Root) : 4 5 2 3 1

for binary tree:

      (1)
     /   \
   (2)    (3)
  /   \
(4)    (5)

*/

:- ['utils/avl'].
:- ['utils/json'].  % for the bowling sample

preorder(Tree, Seq) :- preorder1(Tree, Seq, []).

preorder1(t) --> [].
preorder1(t(K, V, L, R, _)) -->
   [K-V],
   preorder1(L),
   preorder1(R).

/*
?- bowling(Scores),
   json(object(AVL), Scores, ""), 
   avl_get(AVL, 'bowling scores', object(Tree)), 
   preorder(Tree, Seq).

Scores=[123,32,34,98,111,119,...]
AVL=t('bowling scores',object(t('Siggi',array([number(56),number(63)]),...)))
Tree=t('Siggi',array([number(56),number(63)]),...)
Seq=['Siggi'-array([number(56),number(63)]),
     'Jada'-array([number(97)]),
     'Walt'-array([number(250)])]
*/

inorder(Tree, Seq) :- inorder1(Tree, Seq, []).

inorder1(t) --> [].
inorder1(t(K, V, L, R, _)) -->
   inorder1(L),
   [K-V],
   inorder1(R).

/*
?- bowling(Scores), json(object(AVL), Scores, ""), 
   avl_get(AVL, 'bowling scores', object(Tree)), 
   inorder(Tree, InorderSeq).

...
InorderSeq=['Jada'-array([number(97)]),
            'Siggi'-array([number(56),number(63)]),
            'Walt'-array([number(250)])]

*/

/*
b) Can you use preorder/2 from problem part a) in the reverse direction; i.e. 
given a preorder sequence, construct a corresponding tree? If not, make the 
necessary arrangements.

Would you look at that!

?- preorder(Tree, ['Siggi'-array([number(56),number(63)]),
                   'Jada'-array([number(97)]),
                   'Walt'-array([number(250)])]).
Tree=t('Siggi',array([number(56),number(63)]),t,
       t('Jada',array([number(97)]),t,
         t('Walt',array([number(250)]),t,t,_x4366),_x4348),_x4330)

I'LL TAKE IT! ;)
*/

/*
c) If both the preorder sequence and the inorder sequence of the nodes of a 
binary tree are given, then the tree is determined unambiguously. Write a 
predicate pre_in_tree/3 that does the job.

Yeah, okay, Boomer.

d) Solve problems a) to c) using difference lists. Cool! Use the predefined 
predicate time/1 to compare the solutions.

Done. 'Use difference lists'? SONNY, I EAT DIFFERENCE LISTS FOR BREAKFAST!

What happens if the same character appears in more than one node. Try, for 
instance, pre_in_tree(aba,baa,T).
*/

