:- ['library/tree'].

/*
From: 

"Balancing weight-balanced trees," YOICHI HIRAI, KAZUHIKO YAMAMOTO, 2011
https://yoichihirai.com/bst.pdf

Excerpts follow:

3.1 Data structure

The data structure used in the WBT algorithms can be defined as follows 3:

type Size = Int
data Set a = Tip | Bin Size a (Set a) (Set a)

...

size :: Set a -> Size
size Tip = 0
size (Bin sz _ _ _) = sz

singleton :: a -> Set a
singleton k = Bin 1 k Tip Tip

bin :: a -> Set a -> Set a -> Set a
bin k l r = Bin (size l + size r + 1)klr
*/

size(tip, 0).
size(bin(Sz, _, _, _), Sz).

singleton(Elt, bin(1, Elt, tip, tip)).

bin(Elt, Left, Right, bin(Sz, Elt, Left, Right)) :-
   size(Left, L),
   size(Right, R),
   Sz is L + R + 1.

/*
3.2 Balance of WBT

In order to avoid deep, thin trees shaped like a list, WBT algorithms impose a 
balance condition on trees. The balance condition is parameterized with the 
isBalanced predicate taking two trees. First, Tip is balanced. Second, a 
Bin-constructed tree is balanced if

1. the weights of the left and right subtrees satisfy isBalanced predicate, and
2. its left and right subtrees are balanced.

balanced :: Set a -> Bool
balanced Tip = True
balanced (Bin _ _ l r) = isBalanced l r && isBalanced r l
                                        && balanced l && balanced r
*/

balanced(tip).
balanced(bin(_, _, Left, Right)) :-
   isBalanced(Left, Right),
   isBalanced(Right,Left),
   balanced(Left),
   balanced(Right).

/*
The balanced function uses the isBalanced predicate in order to check the first 
condition of balancing. Each WBT algorithm has its own isBalanced predicate, 
which is shown later.
*/

/*
3.3 Creating WBT

insert :: Ord a => a -> Set a -> Set a
insert kx Tip = singleton kx
insert kx (Bin sz ky l r) = case compare kx ky of
   LT -> balanceR ky (insert kx l) r 
   GT -> balanceL ky l (insert kx r) 
   EQ -> Bin sz kx l r
*/

insert_list([]) --> [].
insert_list([H|T]) -->
   insert(H),
   insert_list(T).

insert(Elt, tip, Tree) :- singleton(Elt, Tree).
insert(Elt, Bin, Tree) :-
   term_hash(Elt, EltHash),
   insert1(Elt, EltHash, Bin, Tree).

insert1(Elt, _, tip, Tree) :- singleton(Elt, Tree).
insert1(Elt, EltHash, Bin, Tree) :-
   Bin = bin(_, Node, _, _),
   term_hash(Node, NH),
   Comp is EltHash - NH,
   insert2(Comp, Elt, EltHash, Bin, Tree).

insert2(Comp, Elt, EltHash, bin(_, Node, Left, Right), Tree) :-
   Comp < 0,
   insert1(Elt, EltHash, Left, T1),
   balanceR(Node, T1, Right, Tree).
insert2(Comp, Elt, EltHash, bin(_, Node, Left, Right), Tree) :-
   Comp > 0,
   insert1(Elt, EltHash, Right, T1),
   balanceL(Node, Left, T1, Tree).
insert2(0, Elt, _, bin(Sz, _, L, R), bin(Sz, Elt, L, R)).

/*
After an element is inserted, the balance between the left and right subtrees 
might be broken. This is checked by isBalanced, which uses Δ. If the two 
subtrees are still balanced, a new node is simply created; otherwise, a rotation
is performed. The exact condition depends on whether the original or the variant
WBT is used. If an element is inserted into the right subtree and the balance is
broken, a left rotation is performed.

balanceL :: a -> Set a -> Set a -> Set a balanceL k l r
       | isBalanced l r = bin k l r
       | otherwise      = rotateL k l r
*/

balanceL(Node, Left, Right, Tree) :-
   isBalanced(Left, Right) ->
     bin(Node, Left, Right, Tree)
   ;
     rotateL(Node, Left, Right, Tree).

/*
Let's add in the symmetric predicates. 
*/

balanceR(Node, Left, Right, Tree) :-
   isBalanced(Left, Right) ->
     bin(Node, Left, Right, Tree)
   ;
     rotateR(Node, Left, Right, Tree).

/*
There are two kinds of left rotations.
One is called a single rotation and the other is called a double rotation.
The isSingle predicate, which uses Γ, decides which rotation is used.

rotateL :: a -> Set a -> Set a -> Set a
rotateL k l r@(Bin _ _ rl rr)
  | isSingle rl rr = singleL k l r
  | otherwise = doubleL k l r
rotateL _ _ _ = error "rotateL"

singleL :: a -> Set a -> Set a -> Set a
singleL k1 t1 (Bin _ k2 t2 t3) = bin k2 (bin k1 t1 t2) t3
singleL _ _ _ = error "singleL"

doubleL :: a -> Set a -> Set a -> Set a
doubleL k1 t1 (Bin _ k2 (Bin _ k3 t2 t3) t4)
      = bin k3 (bin k1 t1 t2) (bin k2 t3 t4)
doubleL _ _ _ = error "doubleL"
*/

rotateL(Elt, Left, Right, Tree) :-
   Right = bin(_, _, RL, RR),
   (isSingle(RL, RR) ->
     singleL(Elt, Left, Right, Tree)
   ;
     doubleL(Elt, Left, Right, Tree)).

singleL(Elt, T1, bin(_, Node, T2, T3), Tree) :-
   bin(Elt, T1, T2, T4),
   bin(Node, T4, T3, Tree).

doubleL(K1, T1, bin(_, K2, bin(_, K3, T2, T3), T4), Tree) :-
   bin(K1, T1, T2, Left),
   bin(K2, T3, T4, Right),
   bin(K3, Left, Right, Tree).

/*
Symmetric functions for single and double rotations


Here are the comments to the sources of Data.Set.Internals from GHC:

--   rotateL :: a -> Set a -> Set a -> Set a
--   rotateL x l r@(Bin _ _ ly ry) | size ly < ratio*size ry = singleL x l r
--                                 | otherwise               = doubleL x l r

rotateL and rotateR check.

--   rotateR :: a -> Set a -> Set a -> Set a
--   rotateR x l@(Bin _ _ ly ry) r | size ry < ratio*size ly = singleR x l r
--                                 | otherwise               = doubleR x l r
--
*/

rotateR(Elt, Left, Right, Tree) :-
   Left = bin(_, _, LL, LR),
   (isSingle(LL, LR) ->
      singleR(Elt, Left, Right, Tree)
   ;
      doubleR(Elt, Left, Right, Tree)).

/*
--   singleL, singleR :: a -> Set a -> Set a -> Set a
--   singleL x1 t1 (Bin _ x2 t2 t3)  = bin x2 (bin x1 t1 t2) t3
--   singleR x1 (Bin _ x2 t1 t2) t3  = bin x2 t1 (bin x1 t2 t3)
--
--   doubleL, doubleR :: a -> Set a -> Set a -> Set a
--   doubleL x1 t1 (Bin _ x2 (Bin _ x3 t2 t3) t4) =
--              bin x3 (bin x1 t1 t2) (bin x2 t3 t4)
--   doubleR x1 (Bin _ x2 t1 (Bin _ x3 t2 t3)) t4 =
--              bin x3 (bin x2 t1 t2) (bin x1 t3 t4)
--
*/

singleR(X1, bin(_, X2, T1, T2), T3, Tree) :-
   bin(X1, T2, T3, T4),
   bin(X2, T1, T4, Tree).

doubleR(X1, bin(_, X2, T1, bin(_, X3, T2, T3)), T4, Tree) :-
   bin(X2, T1, T2, Left),
   bin(X1, T3, T4, Right),
   bin(X3, Left, Right, Tree).

/*
Both single and double rotations move a part of the right subtree into the left 
subtree. A single rotation moves the left subtree of the right subtree. A double
rotation moves a smaller part: the left subtree of the tree moved by a single 
rotation. A single rotation can break the balance of the whole tree if the 
subtree being moved is too large. To prevent that the isSingle function chooses 
a double rotation when the subtree is much larger than its right sibling. Each 
WBT algorithm has its own isSingle function, which is shown later. The error 
cases in these above three functions does not occur since the insert operation 
adds one element onto the right subtree.
*/

/*
Other balanced tree algorithms. Logarithmic BST (Roura, 2001) is another variant
of WBT. To implement Logarithmic BST, isBalanced and isSingle use bit operations
and other code can be shared with the WBT family.

(.<.) :: Size -> Size -> Bool
a .<. b
   | a >= b = False
   | otherwise = ((a .&. b) ‘shiftL‘ 1) < b

isBalanced a b = not (size a .<. (size b ‘shiftR‘ 1))

isSingle a b = not (size b .<. size a)

The paper (Roura, 2001) says “··· (the original WBT with 1 + √2, √2) which
is anyway an expensive property to check. This seems to be the main reason not 
to use weighted BSTs as default balancing method.” We show the original WBT with
our choice of parameters (3,2) here in order to compare it with the Logarithmic
BST version shown above.

isBalanced :: Set a -> Set a -> Bool
isBalanced a b = 3* (size a + 1) >= size b + 1

isSingle :: Set a -> Set a -> Bool
isSingle a b = size a + 1 < 2 * (size b + 1)

For mathematical reliability, Logarithmic BST is simpler, but we have shown
rigorous analysis of the original WBT is attainable using Coq. For performance,
we benchmarked Logarithmic WBT against the original WBT with 3, 2 (Figures 13–
15). For large (105 elements) trees on randomized inputs, the original WBT 
performs as well as or slightly better than Logarithmic WBT.

*/

isBalanced(Left, Right) :-
   size(Left, L),
   size(Right, R),
   3 * (L + 1) >= R + 1.

isSingle(Left, Right) :-
   size(Left, L),
   size(Right, R),
   L + 1 < 2 * (R + 1).

/*  ---- TRAVERSAL ---- */

to_list(Tree, Ans) :- to_list1(Tree, Ans, []).

to_list1(tip) --> [].
to_list1(bin(_, N, L, R)) -->
   to_list1(L),
   [N],
   to_list1(R).

/* Membership */

has(Elt, Tree) :-
   term_hash(Elt, EH),
   has1(Elt, EH, Tree).

has1(Elt, _, bin(_, Elt, _, _)).
has1(Elt, EH, bin(_, N, L, R)) :-
   not tree_eq(Elt, N),
   term_hash(N, NH),
   Comp is EH - NH,
   branch(Comp, L, R, Branch),
   has1(Elt, EH, Branch).

branch(Comp, L, R, Branch) :-
   Comp < 0 -> Branch = L ; Branch = R.

/* equality is supposed to be = but the shape can differ, so used this one */

tree_eq(Tree1, Tree2) :-
   to_list(Tree1, T1),
   to_list(Tree2, T2),
   T1 = T2.
tree_eq(Obj1, Obj2) :- Obj1 = Obj2.
