/*
P50 (***) Huffman code.

First of all, consult a good book on discrete mathematics or algorithms for a 
detailed description of Huffman codes!

We suppose a set of symbols with their frequencies, given as a list of fr(S,F) 
terms. Example: 

[fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)]

Our objective is to construct a list hc(S,C) terms, where C is the Huffman code
word for the symbol S. In our example, the result could be 

Hs = [hc(a,'0'), hc(b,'101'), hc(c,'100'), hc(d,'111'), hc(e,'1101'), 
      hc(f,'1100')] 
     [hc(a,'01'),...etc.]. 

The task shall be performed by the predicate huffman/2 defined as follows:

% huffman(Fs,Hs) :- Hs is the Huffman code table for the frequency table Fs
*/

/*
Welp. To implement Huffman codes, we need priority queues.

Oft we go.

Priority queues need heaps, so ...

And we design the heap as a 'leftist tree' a la:

http://typeocaml.com/2015/03/12/heap-leftist-tree/

And BOOM! Did heaps for Prolog. WOOT!
*/

:- ['utils/heap'].

/*
We have this:

?- compare(O, (0.45, a), (0.11, b)).
O=>

yes
?- compare(O, (0.11, a), (0.45, b)).
O=<

yes

So compare/3 prioritizes the first element of a tuple, as it should.

So, for the input data:

[fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)]. 

we need the swap predicate on tuples, and convert these bad boize to tuples, 
maybe? Lessee.

?- swap(fr(a,45), F).
F=fr(45,a)

yes

Yup. swap/2 works out of the box.

and

?- map(swap, [fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)], Frs).
Frs=[fr(45,a),fr(13,b),fr(12,c),fr(16,d),fr(9,e),fr(5,f)]

yes
?- compare(O, fr(45,a),fr(13,b))
.
O=>

yes
?- compare(O, fr(13,b),fr(12,c)).
O=>

yes
?- compare(O, fr(12,c),fr(16,d)).
O=<

yes

compare works with fr/2-types that are properly swapped.
*/

:- ['utils/cat'].

/*
?- insert_list([2,7,17,3,19,100,36,25,1], Heap).
Heap=node(leaf,1,node(node(leaf,7,node(leaf,17,leaf,1),1),...),1)

yes

and ppt(Heap) shows the (tree) structure of the heap.

?- map(swap, [fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)], Frs),
   insert_list(Frs, Heap),
   ppt(Heap),
   get_min(Heap, Min).

Frs=[fr(45,a),fr(13,b),fr(12,c),fr(16,d),fr(9,e),fr(5,f)],
Heap=node(leaf,fr(5,f),node(leaf,fr(9,e),node(node(node(leaf,fr(16,d),...)))))
Min=fr(5,f)

yes

So now we have the frs heaped.

From the wikipedia page:

1. Create a leaf node for each symbol and add it to the priority queue.
2. While there is more than one node in the queue:
   a. Remove the two nodes of highest priority (lowest probability) from the
      queue
   b. Create a new internal node with these two nodes as children and with
      probability equal to the sum of the two nodes' probabilities.
   c. Add the new node to the queue.
3. The remaining node is the root node and the tree is complete.

*/

huffman(Fs,Hs) :- 
   map(swap, Fs, Frs),
   insert_list(Frs, Heap),
   % okay, so that's step 1.
   iterate(Heap, H0),
   codify(H0, Huffman),
   show_with_code(Huffman, H1),
   codes_to_list(H1, Hs, []).

iterate(Heap, Tree) :-
   % 2.
   delete_min(Heap, fr(F0, C0), T0),
   (delete_min(T0, fr(F1, C1), T1) ->
    F2 is F0 + F1,
    insert(fr(F2, [fr(F0, C0), fr(F1, C1)]), T1, T2),
    iterate(T2, Tree)
   ;
    % 3.
    Tree = fr(F0, C0)).

% now I have to assign the codes

codify(Branches, Huffman) :- codify1("", Branches, Huffman).

codify1(Prefix, fr(Bleh, [Branch1, Branch2]), fr(Bleh, [Br1, Br2])) :-
   codify1([48|Prefix], Branch1, Br1),
   codify1([49|Prefix], Branch2, Br2).
codify1(Code, fr(FO, CO), fr(RevCode, FO, CO)) :- 
   reverse(Code, RevCode).

show_with_code(fr(Bleh, [Branch1, Branch2]), fr(Bleh, [Br1, Br2])) :-
   show_with_code(Branch1, Br1),
   show_with_code(Branch2, Br2).
show_with_code(fr(Str, F0, C0), fr(Atom, F0, C0)) :-
   name(Atom, Str).

codes_to_list(fr(_, [Br1, Br2])) -->
   codes_to_list(Br1),
   codes_to_list(Br2).
codes_to_list(fr(Atom, _, C)) --> [hc(C, Atom)].

/*
?- huffman([fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)], X).
X=[hc(a,0),hc(c,100),hc(b,101),hc(f,1100),hc(e,1101),hc(d,111)]

... as my daughter, EM, as a little girl used to say: "Eye. trice. sting..."
*/

/*
A corollary to this exercise is to then encode and decode a document with
this encoding and,

1. see if the document is faithfully reconstructed; and,
2. see by how much the document is compressed with this encoding.
*/
