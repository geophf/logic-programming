:- [p55_cbal_tree].

/*
P56 (**) Symmetric binary trees

Let us call a binary tree symmetric if you can draw a vertical line through the 
root node and then the right subtree is the mirror image of the left subtree. 
Write a predicate symmetric/1 to check whether a given binary tree is symmetric. 
Hint: Write a predicate mirror/2 first to check whether one tree is the mirror 
image of another. We are only interested in the structure, not in the contents 
of the nodes.
*/

mirror(nil, nil).
mirror(t(_,L,nil),t(_,nil,R)) :- mirror(L,R).
mirror(t(_,nil,R),t(_,L,nil)) :- mirror(L,R).
mirror(t(_,L1,R1),t(_,L2,R2)) :-
   mirror(L1,R2),
   mirror(L2,R1).

/*
I'm not sure the above is correct for the definition of mirror/2. We want
L and R to be structurally mirrored to each other, but we don't want each
child branch to be mirrored to each child branch, do we?
*/

symmetric(nil).
symmetric(t(_,L,R)) :- mirror(L,R).
