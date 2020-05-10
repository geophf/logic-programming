/*
P49 (**) Gray code.

An n-bit Gray code is a sequence of n-bit strings constructed according to 
certain rules. For example,

n = 1: C(1) = ['0','1'].
n = 2: C(2) = ['00','01','11','10'].
n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].

Find out the construction rules and write a predicate with the following 
specification:

% gray(N,C) :- C is the N-bit Gray code

Can you apply the method of "result caching" in order to make the predicate 
more efficient, when it is to be used repeatedly?

see the wikipedia article

https://en.wikipedia.org/wiki/Gray_code

for the many, many applications of Gray codes.

Here's how wikipedia defines an n-bit Gray code:

Constructing an n-bit Gray code

The first few steps of the reflect-and-prefix method.

4-bit Gray code permutation

The binary-reflected Gray code list for n bits can be generated recursively 
from the list for n − 1 bits by reflecting the list (i.e. listing the entries 
in reverse order), prefixing the entries in the original list with a binary 0, 
prefixing the entries in the reflected list with a binary 1, and then 
concatenating the original list with the reversed list.[11] For example, 
generating the n = 3 list from the n = 2 list:

2-bit list:    00, 01, 11, 10	 
Reflected:                      10, 11, 01, 00
Prefix old entries with 0:    000, 001, 011, 010,	 
Prefix new entries with 1:                         110, 111, 101, 100
Concatenated:                 000, 001, 011, 010,  110, 111, 101, 100

The one-bit Gray code is G1 = (0, 1). This can be thought of as built 
recursively as above from a zero-bit Gray code G0 = ( Λ ) consisting of a 
single entry of zero length. This iterative process of generating Gn+1 from Gn 
makes the following properties of the standard reflecting code clear:

* Gn is a permutation of the numbers 0, ..., 2n − 1. (Each number appears 
  exactly once in the list.)
* Gn is embedded as the first half of Gn+1.
* Therefore, the coding is stable, in the sense that once a binary number 
  appears in Gn it appears in the same position in all longer lists; so it 
  makes sense to talk about the reflective Gray code value of a number: 
  G(m) = the m-th reflecting Gray code, counting from 0.
* Each entry in Gn differs by only one bit from the previous entry. (The 
  Hamming distance is 1.)
* The last entry in Gn differs by only one bit from the first entry. (The code 
  is cyclic.)

These characteristics suggest a simple and fast method of translating a binary 
value into the corresponding Gray code.
*/

:- ['utils/list'].

gray(1, ["0", "1"]).
gray(N, C) :-
   N > 1,
   M is N - 1,
   gray(M, Src),
   reflect(Src, Dest),
   prefix(48, Src, Src1),
   prefix(49, Dest, Des1),
   append(Src1, Des1, C).

reflect(A, B) :- reverse(A, B).
prefix(C, A, B) :- map(prepend_each(C), A, B).
prepend_each(H, List, [H|List]).

gray_code(Str, Code) :- name(Code, [103|Str]).

/*
?- gray(2, C), map(gray_code, C, Code).
C=[[48,48],[48,49],[49,49],[49,48]],
Code=[g00,g01,g11,g10]

yes
?- gray(3, C), map(gray_code, C, Code).
C=[[48,48,48],[48,48,49],[48,49,49],[48,49,48],...]
Code=[g000,g001,g011,g010,g110,g111,g101,g100]

yes
?- gray(4, C), map(gray_code, C, Code).
C=[[48,48,48,48],[48,48,48,49],[48,48,49,49],...]
Code=[g0000,g0001,g0011,g0010,g0110,g0111,g0101,...]

All, that's fine, but then:

yes
?- gray(20, C), map(gray_code, C, Code).
*** heap overflow by 48 bytes (safety left: 130960 bytes)
culprit=>term_append/3
*** Not enough memory recovered during GC, tolerance=1040356 (bytes)
 *** Please start with more heap, using option -h

So, instead of recursing down to the bottom, we need to build from the bottom.

Get me?

:- ['utils/list'].

gray(1, ["0", "1"]).
gray(N, C) :-
   N > 1,
   gray(1, Seed),
   repeat(N, 0, [_|Times]),
   reduce(doubler, Seed, Times, C).

doubler(_, Src, Doubled) :-
   reflect(Src, Dest),
   prefix(48, Src, Src1),
   prefix(49, Dest, Des1),
   append(Src1, Des1, Doubled).

reflect(A, B) :- reverse(A, B).
prefix(C, A, B) :- map(prepend_each(C), A, B).
prepend_each(H, List, [H|List]).

gray_code(Str, Code) :- name(Code, [103|Str]).

Of course, 2 ** 20 is a X=1.04858e+06-element list, so ...

?- gray(10, C), map(gray_code, C, Code).
C=[[48,48,48,48,48,48,48,48,48,48],[48,48,48,48,48,48,48,48,48,49],...]
Code=[g0000000000,g0000000001,g0000000011,g0000000010,g0000000110, ...]

with no problems (and in no observed time) under the new system.

But it did just as well under the old-system, too. So, you say "potato," I
say "vodka." And choose whichever approach suites you best, I say.
*/

