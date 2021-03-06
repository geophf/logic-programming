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

SELECT DISTINCT ?item ?itemLabel ?genre ?genreLabel 
                (year(xsd:dateTime(?pubdate)) as ?year) WHERE {
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

:- ['utils/io'].
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
   json(Obj, JSON, _),
   write('And the winner is...'), nl, nl,
   write(Obj), nl,
   json_to_terms(Obj, Terms),
   do(write_term, Terms), nl,
   length(Terms, Len),
   do(writsp, ['Processed', Len, films]), nl, nl.

sample_json('[{"item":"http://www.wikidata.org/entity/Q22674122",
  "itemLabel":"Duck Duck Goose",
  "year":"2020",
  "genre":"http://www.wikidata.org/entity/Q157443",
  "genreLabel":"comedy film"},
 {"item":"http://www.wikidata.org/entity/Q12302227",
  "itemLabel":"Artemis Fowl",
  "year":"2020",
  "genre":"http://www.wikidata.org/entity/Q319221",
  "genreLabel":"adventure film"},
 {"item":"http://www.wikidata.org/entity/Q29021224",
  "itemLabel":"Bad Boys for Life",
  "year":"2020",
  "genre":"http://www.wikidata.org/entity/Q959790",
  "genreLabel":"crime film"},
 {"item":"http://www.wikidata.org/entity/Q28912376",
  "itemLabel":"The New Mutants",
  "year":"2020",
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
   Fn = movie,  % (title(T), genre(G), published(Year)),
   Translators = [xform(itemLabel, string(T), title(T)),
                  xform(genreLabel, string(G), genre(G)),
                  xform(year, string(Year), published(Year))],
   map(json_to_term(Fn, Translators), List, Terms).

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

Note that these terms are not very Prolog-y, meaning: I can't consult a file
containing these facts (the atoms must be quoted first).

By changing write/1 to print/1, I get prolog-y terms:

movie(title('The 40-Year-Old Version'),genre('comedy film'),published(2020)).
movie(title('Dinner in America'),genre('comedy-drama'),published(2020)).
movie(title('I Am Fear'),genre('thriller film'),published(2020)).

... but it's not a panacea:

movie(title(1917),genre('war film'),published(2020)).

... but it'll do for the present.

... also (') needs to be escaped, oh, well.
*/
