from https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/

The original address of this page is: 

https://prof.ti.bfh.ch/hew1/informatik3/prolog/p-99/

P-99: Ninety-Nine Prolog Problems

werner.hett@bfh.ch or werner.hett@gmail.com

The purpose of this problem collection is to give you the opportunity to 
practice your skills in logic programming. Your goal should be to find the most 
elegant solution of the given problems. Efficiency is important, but logical 
clarity is even more crucial. Some of the (easy) problems can be trivially 
solved using built-in predicates. However, in these cases, you learn more if you
try to find your own solution.

Every predicate that you write should begin with a comment that describes the 
predicate in a declarative statement. Do not describe procedurally, what the 
predicate does, but write down a logical statement which includes the arguments 
of the predicate. You should also indicate the intended data types of the 
arguments and the allowed flow patterns.

The problems have different levels of difficulty. Those marked with a single 
asterisk (&lowast;) are easy. If you have successfully solved the preceeding 
problems you should be able to solve them within a few (say 15) minutes. 
Problems marked with two asterisks (&lowast;&lowast;) are of intermediate 
difficulty. If you are a skilled Prolog programmer it shouldn't take you more 
than 30-90 minutes to solve them. Problems marked with three asterisks 
(&lowast;&lowast;&lowast;) are more difficult. You may need more time (i.e. a 
few hours or more) to find a good solution.

note: the solutions provided here are implemented in Paul Tarau's
[bin prolog](https://github.com/ptarau/binprolog).

## Sections

### Working with Prolog lists p01 - p28

A list is either empty or it is composed of a first element (head) and a tail, 
which is a list itself. In Prolog we represent the empty list by the atom `[]`
and a non-empty list by a term `[H|T]` where `H` denotes the head and `T` 
denotes the tail.

### Arithmetic p31 - p41

### Logic and Codes p46 - p50

### Binary Trees p54 - p69
> (problems p58-p61 I consider answered by [utils/avl](https://github.com/geophf/logic-programming/blob/master/prolog/utils/avl.pl))

A binary tree is either empty or it is composed of a root element and two 
successors, which are binary trees themselves.

In Prolog we represent the empty tree by the atom `nil` and the non-empty tree 
by the term `t(X,L,R)`, where `X` denotes the root node and `L` and `R` denote 
the left and right subtree, respectively. The example tree depicted opposite is 
therefore represented by the following Prolog term:

```
        (a)
       /   \
    (b)     (c)
   /   \       \
(d)     (e)     (f)
               /
            (g)
```

`T1 = t(a,t(b,t(d,nil,nil),t(e,nil,nil)),t(c,nil,t(f,t(g,nil,nil),nil)))`

Other examples are a binary tree that consists of a root node only:

`T2 = t(a,nil,nil)` or an empty binary tree: `T3 = nil`

You can check your predicates using these example trees. They are given as 
test cases in p54.

### Multiway Trees p70 - 

A multiway tree is composed of a root element and a (possibly empty) set of 
successors which are multiway trees themselves. A multiway tree is never 
empty. The set of successor trees is sometimes called a forest.

In Prolog we represent a multiway tree by a term `t(X,F)`, where `X` denotes 
the root node and `F` denotes the forest of successor trees (a Prolog list). 
The example tree depicted opposite is therefore represented by the following 
Prolog term:

```
    (a)
   / | \
(f) (c) (b)
 |     /   \
(g) (d)     (e)
```

`T = t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])`
