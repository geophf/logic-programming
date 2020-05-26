# logic-programming
An exploration of logic programming; leaning toward pragmatism and purity, and yes: you can do both.

So, yeah. I'd like to program in a language that's easy to code (full-featured),
does what I say (declarative), doesn't hurt me (pure).

Is that prolog? ... may...be? Haskell is wonderful, except when I want to do
logic programming, which is all the time, so I'm always building logic 
frameworks on top of Haskell, then using Haskell. I'd like to skip that step,
maybe? (maybe not: building logical frameworks can be fun, too, e.g.: [Reasoned
Schemer](https://mitpress.mit.edu/books/reasoned-schemer-second-edition)).

Prolog has its quirks. I also built an actionable ontology and deployed that
to production... more than once, in Prolog, so I like Prolog.

Sometimes.

Except when I wish to program functionally, or typefully, which is all the time.

So, you see, I have a quandary. If I had Logic Haskell, or, contrapositively,
Functional Prolog, ... both with Pi-types, I'd be ... happy?

I suppose I have to work on my happiness.

So, here I am: working on my happiness.

You may see some prolog here, you may see some haskell here. ... Idris? I have
to settle on a functional/logical/pragmatic language, and until then, I'll 
explore the established languages until I can parse JSON like python does, and
read and write to graph database like, ... well, python does.

Le sigh.

## Postlude

So, I now have a cat(egory) library in the making and have read up on higher-order functions
in Prolog, so I like all these things. And implemented some data types. All these sit in my
[stdlib](https://github.com/geophf/logic-programming/blob/master/prolog/utils/stdlib.pl).

Now, ... typing in Prolog, that'll be nice, as well as a wee-bit more of the functional style.

Eh, programming is a work-in-progress, isn't it. Just like life.

## TODOs

* Encode and decode documents using my [Huffman encoder](https://github.com/geophf/logic-programming/blob/master/prolog/p99/p50_huffman_code.pl)
* REST access *(done)* ... or maybe shift data in and out, a la RedShift?

## TODOnes

* [AVL Trees](https://github.com/geophf/logic-programming/blob/master/prolog/utils/avl.pl) ... (you know: borrowed and modified).
* [Heaps/Priority Queues](https://github.com/geophf/logic-programming/blob/master/prolog/utils/heap.pl) ... (again: borrowed).
* [Huffman code](https://github.com/geophf/logic-programming/blob/master/prolog/p99/p50_huffman_code.pl) ... but see TODOs
* [JSON parsing library](https://github.com/geophf/logic-programming/blob/master/prolog/utils/json.pl)

> ... but now we need to add custom deserializers that iterate over each node.
> ... (started reification from JSON to Prolog with [02_jsonin](https://github.com/geophf/logic-programming/blob/master/prolog/things/02_jsonin.pl))
* REST access and (Cypher/neo4j-bridge](https://github.com/geophf/logic-programming/blob/master/prolog/things/04_REST_endpoint.pl)
> ... and we also have a neo4j-on-the-cloud prolog graph store! YUS! 

## Further Reading

* [An Elementary Prolog Library](http://www.cs.otago.ac.nz/staffpriv/ok/pllib.htm)
* ... and further [Richard O'Keefe musings](http://www.cs.otago.ac.nz/staffpriv/ok/)
* [prolog :- tutorial.](https://www.cpp.edu/~jrfisher/www/prolog_tutorial/contents.html)
* [Proving Metatheorems](http://twelf.org/wiki/Proving_metatheorems:Full_LF) in [Twelf](http://twelf.org/wiki/Main_Page)
* [P99](https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/) ... 99 problems in Prolog
* [Reasoned Schemer](https://mitpress.mit.edu/books/reasoned-schemer-second-edition) and [some workings](https://github.com/pkrumins/the-reasoned-schemer) on that problem set.
* [binprolog](https://github.com/ptarau/binprolog) sources (bp)
