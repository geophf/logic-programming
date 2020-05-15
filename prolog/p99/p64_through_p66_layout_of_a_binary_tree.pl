/*

... blah-blah-blah, layout a binary tree, ... blah, blah, blah.

This is already done by:
*/

:- ['utils/cat'].
:- ['utils/avl'].
:- ['utils/list'].
:- ['library/tree'].

lay_me_out_baybee :-
   List = [a,b,d,c,e],
   map(dup, List, Tups),
   list_to_avl(Tups, Tree),
   ppt(Tree).

/*
?- lay_me_out_baybee.
                                   t
                                   |
     .--.--------.--------------------------.--------------------.
     |  |        |                          |                    |
     b  b        t                          t                    3
                 |                          |                     
           .--.--.--.--.  .--.--------.--------------.--------.
           |  |  |  |  |  |  |        |              |        |
           a  a  t  t  1  d  d        t              t        2
                                      |              |         
                                .--.--.--.--.  .--.--.--.--.
                                |  |  |  |  |  |  |  |  |  |
                                c  c  t  t  1  e  e  t  t  1
yes
*/
