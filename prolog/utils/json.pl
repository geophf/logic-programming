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

... but actually json_to_term/4 is more in line with a JSON-to-prolog-term
translation.
*/

:- ['utils/list'].
:- ['utils/avl'].

json(Obj) --> value(Obj).

object(object(Empty)) -->
   "{" , whitespace, "}",
   { avl_empty(Empty) }.
object(object(Obj)) -->
   "{", kv(Pair), commaedPairs(Pairs), "}",
   { list_to_avl([Pair|Pairs], Obj) }.

commaedPairs([Pair|Pairs]) -->
   whitespace, ",", whitespace, kv(Pair),
   commaedPairs(Pairs).
commaedPairs([]) --> whitespace.

kv(Key - Val) --> 
   whitespace, string(K), 
   whitespace, ":", value(Val),
   { string(Key) = K }.

array(array(Arr)) --> 
   "[", elements(Arr) , "]".

elements([V|Vs]) -->
   value(V),
   commaedValues(Vs).
elements([]) --> whitespace.

commaedValues([V|Vs]) --> ",", value(V), commaedValues(Vs).
commaedValues([]) --> whitespace.

whitespace --> { white(W) }, [W], whitespace.
whitespace --> [].

white(32).   % SPACE
white(10).   % CARRIAGE_RETURN
white(13).   % LINE_FEED
white(9).    % TAB

/*
ASCII character table at:

http://www.asciitable.com/

But: SHOOT! SWI-Prolog treats '\' as an escaper, bp prolog does not.

Also not/1 is an operator in bp prolog, but a predicate in SWI-Prolog
*/

string(string(Str)) --> 
   """", 
   chars(Cs), 
   """", 
   { name(Str, Cs) }.

chars(Cs) --> 
   char(C1) -> chars(C1s), { Cs = [C1|C1s] }
             ; { Cs = [] }.

char(C, [C|Cs], Cs) :-
   DOUBLE_QUOTE = 34,
   BACK_SLASH = 92,
   not(member(C, [DOUBLE_QUOTE, BACK_SLASH])).
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
digits([], [], []).

fractional(fraction(F)) -->
   ".",
   digits(Ds),
   { reverse(Ds, Rs),
     reduce(addmul(0.1), 0, Rs, F) }.

addmul(Mult, H, Sum, Ans) :-
   Ans is Mult * (H + Sum).

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

/*
json_to_term/2.

So, here's a stab at tranlating JSON to prolog terms where the JSON is of
the dictionary-form.

Functor = fn(t1(V1), ... tn(Vn))
Translators = [Key1 - j1(V1), ... KeyN - jn(Vn)]

... or, whatever. You get the idea, right?

json_to_term(Functor, Translators, object(AVL)) :-
   do(json_translation(AVL, Functor), Translators).

json_translation(AVL, _Functor, Key - Matcher) :-
   avl_get(AVL, Key, Matcher).

Ugh. That didn't work. :( I guess I have to do a construction from a mapping.

Functor = some f
Translators = [xform(Key1, f11(X), f21(X)), ... xform(KeyN, f1n(X), f2n(X))]
*/

json_to_term(Functor, Translators, object(AVL), Term) :-
   copy_term(Translators, Ts),
   map(json_translate(AVL), Ts, Args),
   Term =.. [Functor|Args].

json_translate(AVL, xform(Key, A, B), B) :-
   avl_get(AVL, Key, A).

% A helper predicate to build translators:

translate(Label - Functor, xform(Label, string(T), Fn)) :-
   Fn =.. [Functor, T].

/*
used like this:

translators(Ts) :-
   map(xlate, [itemLabel - title, genreLabel - genre, year - published], Ts).

in:

?- list_to_avl([itemLabel - string('Ghost Busters'), 
                year - string(2019), 
                genreLabel - string('comedy film')], AVL),
   translators(Translators),
   json_to_term(movie, Translators, object(AVL), Ans).

AVL=t(itemLabel,string('Ghost Busters'),t(genre,string('comedy film'),...))
Fn=movie,
Translators = [xform(itemLabel, string(T), title(T)), ...]
Ans=movie(title('Ghost Busters'),published(2019),genre('comedy film'))

yes

The translate/2 function assumes the value is a string/1 for now.

Another example:

?- name('[{"entree" : "Connecticut Lobster Roll",
           "price": 16.95 },
          {"side" : "Lobster mac and cheeze",
           "price":  5.95 }]', JSON),
   json(array([E, S]), JSON, []),
   PriceXform = xform(price, number(N), price(N)),
   translate(entree-item, EntreeXform),
   json_to_term(entree, [EntreeXform, PriceXform], E, E1),
   translate(side-item, SideXform),
   json_to_term(side, [SideXform, PriceXform], S, S1).

JSON = [91, 123, 34, 101, 110, 116, 114, 101, 101|...],
E = object(t(entree, string('Connecticut Lobster Roll'), t, ...))
S = object(t(side, string('Lobster mac and cheeze'), ...))
PriceXform = xform(price, number(N), price(N)),
EntreeXform = xform(entree, string(_22408), entree(_22408)),
E1 = entree(item('Connecticut Lobster Roll'), price(21.9)),
SideXform = xform(side, string(_22510), side(_22510)),
S1 = side(item('Lobster mac and cheeze'), price(10.9)) 

yes
n.b.: Since we have copy_term/2 in json_to_term/4, we can use PriceXform twice.

... oops! Found a bug with numbers! ... fixed number/3 ... REEEEEEE! and answer
is now:

... blah, blah, blah, ...

E1=entree(item('Connecticut Lobster Roll'),price(16.95)),
S1=side(item('Lobster mac and cheeze'),price(5.95))

WOOT!
*/
