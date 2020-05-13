/*
01_includin.

Okay. I've proved I can read argv and write to stdout (00_readin_ritin).

Now I want to include other prolog files to help me to compute a result.

Let's say I ingest an input from argv. Now I want to do frequency analysis on
the bytes ... 'characters'? ... received.

I'll put that into a good-ol' bag data structure, aka AVL-tree.
*/

:- ['utils/avl'].
:- ['utils/cat'].
:- ['utils/heap'].
:- ['utils/list'].
:- ['utils/math'].

:- initialization(main, main).

main(Argv) :- char_count(Argv).

char_count([]) :-
   write('You must call this program with a sentence to analyze.'),
   nl.

% ^-- so I need, leik, an io library, leik, ... and stuff.

char_count([Atom|_]) :-
   % lesson learnt: argv = [Atom|Atoms], not [Chars|Charssss]
   name(Atom, Chars),
   reduce(putter, t, Chars, Tree),
   avl_to_list(Tree, Counts),
   % now that we have the counts, let's sort by freq ... with a heap.
   to_heap(Counts, Heap),
   % and print the results
   write('Character counts: '), nl,
   heap_to_list(Heap, Freqs),
   reverse(Freqs, Fracks),
   do(rev_print_tuple, Fracks).

to_heap(Counts, Heap) :-
   map(swap, Counts, C1),
   list_to_heap(C1, Heap).

putter(K, T0, Tree) :- avl_alter_f(T0, K, 1, succ, Tree).

rev_print_tuple(Tup) :-
   unpair(Tup, Count, Char),
   name(Atom, [Char]),
   do(write, ['"', Atom, '": ', Count]), nl.   % um ... yay? (puke-emoji)

% yeah, I really need an io library...

/*
Stand-alone compiled with:

$ swipl -o counter -c things/01_includin.pl

Execution:

$ ./counter "Hey, mama"                    
Character counts: 
"m": 2
"a": 2
"y": 1
"e": 1
"H": 1
",": 1
" ": 1

A more-interesting (and reflexive) example:

$ TEXT=`cat things/01_includin.pl`; ./counter $TEXT
Character counts: 
" ": 276
"t": 109
"e": 106
"a": 94
"
": 89
"r": 71
"n": 69
"o": 66
"s": 60
"i": 55
"l": 52
",": 52

Now that's a sample that can be Huffman-encoded, eh? eh?
*/
