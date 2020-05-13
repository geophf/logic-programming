/* 
The JSON grammar, pitches. 

from: https://www.json.org/json-en.html
*/

/*
The structure of a Prolog { block } is:

?- { a: b, c: d} =.. [Fun|[Args|_]], fst(Args, A).
Fun={},
Args=a:b,c:d,
A=a:b

So to build a { block } iteratively we need a little category-magic.
*/

:- ['utils/list'].
:- ['utils/avl'].

json(Obj) --> value(Obj).

object(object(Empty)) -->
   % { write('Okay, is this an empty object?'), nl },
   "{" , whitespace, "}",
   % { write('Yes. Yes, it is.'), nl },
   { avl_empty(Empty) }.
object(object(Obj)) -->
   % { write('Let us fill an object with pairs...'), nl },
   "{", kv(Pair), commaedPairs(Pairs), "}",
   % { write('Pairs... and kiwi fruit ... it is!'), nl },
   { list_to_avl([Pair|Pairs], Obj) }.

commaedPairs([Pair|Pairs]) -->
   % { write('Trying a pair'), nl },
   whitespace, ",", whitespace, kv(Pair),
   % { write('got pair '), write(Pair), nl },
   commaedPairs(Pairs).
commaedPairs([]) --> whitespace.

kv(Key - Val) --> 
   % { write('Hey, can I KV this?'), nl },
   whitespace, string(K), 
   % { write('Got string '), write(K), nl },
   whitespace, ":", value(Val),
   % { write('Got value '), write(Val), nl },
   { string(Key) = K }.

array(array(Arr)) --> 
   % { write('I am parsing an array') },
   "[", elements(Arr) , "]".
   % { write(' ... and I parsed an array.'), nl }.

elements([V|Vs]) -->
   % { write('I am parsing an array value') },
   value(V),
   % { write('... and I parsed an array value: '), write(V), nl },
   commaedValues(Vs).
elements([]) --> whitespace.

commaedValues([V|Vs]) --> ",", value(V), commaedValues(Vs).
commaedValues([]) --> whitespace.

whitespace --> { white(W) }, [W], whitespace.
whitespace --> [].

white(32).
white(10).
white(13).
white(9).

/*
ASCII character table at:

http://www.asciitable.com/

But: SHOOT! SWI-Prolog treats '\' as an escaper, bp prolog does not.

Also not/1 is an operator in bp prolog, but a predicate in SWI-Prolog
*/

string(string(Str)) --> 
   % { write('Is this a string?'), nl },
   """", 
   % { write('I got the open quote'), nl },
   chars(Cs), 
   """", 
   { name(Str, Cs) }.
     % write('String is '), write(Str) }.

chars(Cs) --> 
   char(C1) -> chars(C1s), { Cs = [C1|C1s] }
             ; { Cs = [] }.

char(C, [C|Cs], Cs) :-
   DOUBLE_QUOTE = 34,
   BACK_SLASH = 92,
   not(member(C, [DOUBLE_QUOTE, BACK_SLASH])).
   % write('I got char '), print(C), nl.
char(C) --> escaped(C).

escaped(C) --> "\\", escaped_char(C).

escaped_char(34) --> """".
escaped_char(92) --> "\\".
escaped_char(47) --> "/".
escaped_char(8) --> "b".
escaped_char(12) --> "f".
escaped_char(10) --> "n".
escaped_char(13) --> "r".
escaped_char(9) --> "t".
escaped_char(U) --> "u", hex4(U).

hex4(N) --> hex(A), hex(B), hex(C), hex(D), { nhexify([A, B, C, D], N) }.

hex(H, [C|Cs], Cs) :- digit(C, H).
hex(H, [C|Cs], Cs) :-
   is_lower(C),
   C < 103,
   H is C - 87.
hex(H, [C|Cs], Cs) :-
   is_upper(C),
   C < 71,
   H is C - 55.

is_digit(C) :- C > 47, C < 58.
digit(C, D) :- is_digit(C), D is C - 48.

is_lower(C) :- C > 96, C < 123.
is_upper(C) :- C > 64, C < 91.

nhexify(Hexen, N) :- reduce(muladd(16), 0, Hexen, N).

muladd(Base, D, Accum, Sum) :- Sum is Base * Accum + D.

/* ------------------------ VALUE parsing ----------------------------- */

value(Val) --> whitespace, value1(Val), whitespace.

value1(Str) --> string(Str).
value1(Obj) --> object(Obj).
value1(Arr) --> array(Arr).
value1(N) --> number(N).
value1(true) --> "true".
value1(false) --> "false".
value1(null) --> "null".

/* -------------- Numbers ... REEEEEEEEE! ----------------------------- */

number(number(N)) -->
   "-",
   whole(number(M)),
   { N is M * -1 }.
number(number(N)) -->
   whole(number(N)).

whole(number(N)) -->
   digits(Ds),
   fractional(fraction(F)),
   exponent(exponent(E)),
   { reduce(muladd(10), 0, Ds, D),
     N is (D + F) ** E }.
whole(number(N)) -->
   digits(Ds),
   fractional(fraction(F)),
   { reduce(muladd(10), 0, Ds, D),
     N is D + F }.
whole(number(N)) -->
   digits(Ds),
   exponent(exponent(E)),
   { reduce(muladd(10), 0, Ds, D),
     N is D ** E }.
whole(number(D)) -->
   digits(Ds),
   { reduce(muladd(10), 0, Ds, D) }.

digits(Ds, [C|Cs], Es) :-
   digit(C, D) -> digits(D1s, Cs, Es), Ds = [D|D1s] ; Es = [C|Cs], Ds = [].

fractional(fraction(F)) -->
   ".",
   digits(Ds),
   { reduce(muladd(0.1), 0, Ds, F) }.

exponent(exponent(E), [C|Cs], Es) :-
   member(C, "eE"),
   exponent1(exponent(E), Cs, Es).

exponent1(exponent(E)) -->
   sign(S),
   digits(Ds),
   { reduce(muladd(10), 0, Ds, E1),
     E is S * E1 }.

sign(1) --> "+".
sign(-1) --> "-".
sign(1, [C|Cs], [C|Cs]) :- is_digit(C).

/*
Let's create an example JSON from Walt's, Siggi's, and Jada's bowling scores 
from:

https://www.fictionpress.com/s/3326634/8/Æfintýri-Book-II-Jada

Reference JSON is:

{ "bowling scores" : { "Siggi" : [56, 63], "Jada" : [97], "Walt": [250] } } 
*/

bowling(Scores) :-
   Atom = '{ "bowling scores" : 
             { "Siggi" : [56, 63], 
               "Jada" : [97], 
               "Walt": [250] } }',
   name(Atom, Scores).

/*
Resulting AVL-tree is from:

?- bowling(Scores), json(JSON, Scores, X), ppt(JSON).

is:

JSON=object(t('bowling scores',
              object(t('Siggi',array([number(56),number(63)]),
                       t('Jada',array([number(97)]),t,t,1),
                       t('Walt',array([number(250)]),t,t,1),2)),t,t,1)).
*/
