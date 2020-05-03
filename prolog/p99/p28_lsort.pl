:- ['utils/stdlib'].
:- ['library/tree'].

/*
P28 (**) Sorting a list of lists according to length of sublists

a) We suppose that a list (InList) contains elements that are lists themselves. 
The objective is to sort the elements of InList according to their length. E.g. 
short lists first, longer lists later, or vice versa.

Example:

?- lsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],L).
L = [[o], [d, e], [d, e], [m, n], [a, b, c], [f, g, h], [i, j, k, l]]
*/

/*
We do have this:

?- Comparator = (>), Pred =.. [Comparator, 5, 3], call(Pred).
Comparator=>,
Pred=5 > 3

To create our sort criterium.
*/

lenCmp(Comp, L0, L1) :-
   length(L0, A),
   length(L1, B),
   Pred =.. [Comp, A, B],
   call(Pred).

/*
qsort algorithm from wikipedia: https://en.wikipedia.org/wiki/Quicksort

nupe, from sorting in Haskell: 

https://www.kovach.me/posts/2012-04-03-sorting.html

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs)  = quickSort smaller ++ [x] ++ quickSort larger
    where smaller = filter (<=x) xs
          larger  = filter (> x) xs
*/

qsort(_, [], []).
qsort(Pred, [H|T], Sorted) :-
   apply(Pred, H, LeftFn),
   partition(LeftFn, T, Ls, Rs),
   qsort(Pred, Ls, QLs),
   qsort(Pred, Rs, QRs),
   concat([QLs, [H], QRs], Sorted).

/*
concat(Lists, List) :- concat1(Lists, List, []).

concat1([]) --> [].
concat1([H|T]) --> H, concat1(T).

That was easy. So, now all I have to do is to define the called predicates

apply(List, Pred) :-
   apply1(List, DecomposedList, []),
   Pred =.. DecomposedList.

apply1([]) --> [].
apply1([H|T]) -->
   { is_list(H) -> List = [H]; H =.. List },
   List,
   apply1(T).

filter(Pred, List, Filtered) :- filter1(Pred, List, Filtered, []).

filter1(_, []) --> [].
filter1(Pred, [H|T]) -->
   { apply([Pred, H], Fn),
     call(Fn) -> Ans = [H]; Ans = [] },
   Ans,
   filter1(Pred, T).

partition(Fn, List, Ls, Rs) :-
   partition1(Fn, List, RevLs, [], RevRs, []),
   reverse(RevLs, Ls),
   reverse(RevRs, Rs).

partition1(_, [], Ls, Ls, Rs, Rs).
partition1(Fn, [H|T], AnsLs, Ls, AnsRs, Rs) :-
   apply([Fn, H], Pred),
   (call(Pred) -> NewLs = [H|Ls], NewRs = Rs; NewLs = Ls, NewRs = [H|Rs]),
   partition1(Fn, T, AnsLs, NewLs, AnsRs, NewRs).
*/

lsort(Lists, Ans) :- qsort(lenCmp(>), Lists, Ans).

/*
cool. Moving concat/2, partition/4, and filter/3 to utils/list library.

And, of course, that means we need to create a categories library at utils/cat.
*/

/*
b) Again, we suppose that a list (InList) contains elements that are lists 
themselves. But this time the objective is to sort the elements of InList 
according to their length frequency; i.e. in the default, where sorting is done 
ascendingly, lists with rare lengths are placed first, others with a more 
frequent length come later.

Example:

?- lfsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],L).
L = [[i, j, k, l], [o], [a, b, c], [f, g, h], [d, e], [d, e], [m, n]]

Note that in the above example, the first two lists in the result L have length 
4 and 1, both lengths appear just once. The third and forth list have length 3 
which appears, there are two list of this length. And finally, the last three 
lists have length 2. This is the most frequent length.
*/

/*
Well, first we need to get the length-frequencies, creating a lookup-table for 
that.
*/

/*
Which means we need to create the map-type? Or use an associative-list?

Using avl_tree implementation from:

https://github.com/cmungall/blipkit/blob/master/packages/blipcore/avl.pro
*/

/*
From our utils/list library:

?- map(length, [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]], Lens).
Lens=[3,2,3,2,4,2,1]

So, an AVL tree of the above (using my avl_alter_f, will look like:
*/

addLengthFreq(Num, AVL, Tree) :- avl_alter_f(AVL, Num, 1, succ, Tree).

/*
?- List = [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],
   map(length, List, Lens),
   reduce(putter, t, Lens, Tree),
   avl_to_list(Tree, Freqs).

List=[[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]]
Lens=[3,2,3,2,4,2,1],
Tree=t(3,2,t(2,3,t(1,1,t,t,1),t,2),t(4,1,t,t,1),3),
Freqs=[1-1,2-3,3-2,4-1]

yes

So, with this AVL tree, we zip the length-frequency back onto each sublist:
*/

zipLengthFreqs(AVLTree, SubList, Freq - SubList) :-
   length(SubList, Len),
   avl_get(AVLTree, Len, Freq).

/*
?- apply(zipper, Tree, Zfn), map(Zfn, List, FreqList).

Zfn=zipper(t(3,2,t(2,3,t(1,1,t,t,1),t,2),t(4,1,t,t,1),3)),
FreqList=[2-[a,b,c],3-[d,e],2-[f,g,h],3-[d,e],1-[i,j,k,l],3-[m,n],1-[o]]

yes

To get the result, we qsort on fst and map snd on that result.
*/

fstCmp(X, Y) :-
   fst(X, L),
   fst(Y, R),
   L > R.

lfsort(List, FreqSorted) :-
   map(length, List, Lens),
   reduce(addLengthFreq, t, Lens, Tree),
   map(zipLengthFreqs(Tree), List, FreqList),
   qsort(fstCmp, FreqList, SortedFreqs),
   map(snd, SortedFreqs, FreqSorted).

/*
?- lfsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]], Sorted).
Sorted=[[i,j,k,l],[o],[a,b,c],[f,g,h],[d,e],[d,e],[m,n]]

yes

As they say in French: Boum, Boum, Boum!
*/

