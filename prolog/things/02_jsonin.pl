/*
02_jsonin

Hey, everybody on the cloud likes json, and why not, says I!

I want to read in some JSON, JSON some JSON, then do something with it, like...
idk ... eat a turkey club?

YES! LET'S!

nom-nom-nom.

Okay, back on point: we have a file, movies.json, let's pull it in and then
structure it as prolog terms.

The SPARQL that generated this JSON is:

SELECT DISTINCT ?item ?itemLabel ?genre ?genreLabel WHERE {
  ?item wdt:P31 wd:Q11424.
  ?item wdt:P577 ?pubdate.
  ?item wdt:P495 wd:Q30.
  ?item wdt:P364 wd:Q1860.
  ?item wdt:P136 ?genre. 
  FILTER((?pubdate >= "2020-01-01T00:00:00Z"^^xsd:dateTime) 
      && (?pubdate <= "2020-12-31T00:00:00Z"^^xsd:dateTime))
  SERVICE wikibase:label { 
    bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en".
  }
}

So it'd be the movies and the genres we be after, matey! YAARRR! #ImAPirate

Recall that this file is created with

$ swipl -o jsoner -c things/02_jsonin.pl

and run with:

$ TEXT=`cat things/movies.json`; ./jsoner $TEXT

things/movies.json has 431 movies; things/movies-smol.json has 4 films.

things/movies-smol.json is also inlined here as sample_json/1.
*/

:- ['utils/list'].
:- ['utils/json'].
:- ['library/tree'].

:- initialization(main, main).

main([]) :-
   write('Need to pass in the movies-json to parse, and stuff.'), nl.

main([JSON|_]) :- 
   name(JSON, Jason),
   json_this_baybee(Jason).

json_this_baybee(JSON) :-
   % write('JSONin the JSON.'), nl, write(JSON), nl,
   json(Obj, JSON, _),
   write('And the winner is...'), nl, nl,
   write(Obj), nl,
   % ppt(Obj),
   json_to_terms(Obj, Terms),
   do(writln, Terms), nl,
   length(Terms, Len),
   do(writsp, ['Processed', Len, films]), nl, nl.

/*
   (X = [] -> write('The end.')
   ;
   write('And the remainder is...'), nl, nl,
   name(Rest, X),
   write(Rest), nl, nl,
   write('Q.E.D.')),
   nl, nl.
*/

sample_json('[{"item":"http://www.wikidata.org/entity/Q22674122",
  "itemLabel":"Duck Duck Goose",
  "genre":"http://www.wikidata.org/entity/Q157443",
  "genreLabel":"comedy film"},
 {"item":"http://www.wikidata.org/entity/Q12302227",
  "itemLabel":"Artemis Fowl",
  "genre":"http://www.wikidata.org/entity/Q319221",
  "genreLabel":"adventure film"},
 {"item":"http://www.wikidata.org/entity/Q29021224",
  "itemLabel":"Bad Boys for Life",
  "genre":"http://www.wikidata.org/entity/Q959790",
  "genreLabel":"crime film"},
 {"item":"http://www.wikidata.org/entity/Q28912376",
  "itemLabel":"The New Mutants",
  "genre":"http://www.wikidata.org/entity/Q188473",
  "genreLabel":"action film"}]').

/*
Okay.

This works in bp, but fails in SWI-Prolog. Why.

?- sample_json(JSON), main([JSON]).

Eye. trice. sting. 

In interactive mode, SWI-Prolog parses the number 0 then fails fast, whereas
bp prolog parses the entire file and consumes all the movies.

Fixed that (converted character-referencing to use ASCII-codes), but now ppt/1
doesn't work for SWI now. ODTAAT.

But now we do have an array() of JSON objects, so, let's move onto conversions:

?- sample_json(In), 
   name(In, JSON), 
   json(Obj, JSON, []), 
   array(Arr) = Obj, 
   length(Arr, Len),
   [object(H)|_] = Arr,
   avl_get(H, itemLabel, Title),
   avl_get(H, genreLabel, Genre).

...
Len = 4
Tite=string('Duck Duck Goose'),
Genre=string('comedy film')

yes

That's a nice start.
*/

json_to_terms(array(List), Terms) :-
   map(json_to_terms, List, Terms).
json_to_terms(object(AVL), movie(title(Title), genre(Genre))) :-
   avl_get(AVL, itemLabel, string(Title)),
   avl_get(AVL, genreLabel, string(Genre)).

writln(T) :- write(T), nl.
writsp(T) :- write(T), sp.

sp :- write(' ').

/*
... and BOOM! Did that:

movie(title(Duck Duck Goose),genre(comedy film))
movie(title(Artemis Fowl),genre(adventure film))
movie(title(Bad Boys for Life),genre(crime film))
movie(title(The New Mutants),genre(action film))

...

movie(title(I Am Fear),genre(thriller film))
movie(title(Feels Good Man),genre(documentary film))
movie(title(Miss Juneteenth),genre(drama film))

Processed 431 films 
*/
