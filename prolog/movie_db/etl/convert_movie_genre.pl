% creates Prolog fact-table from movie_genre.json

:- ['utils/io'].
:- ['utils/json'].
:- ['utils/list'].

:- initialization(main, main).

main([]) :-
   write('Provide the movie-genre JSON data as first argument, FOO!'), nl.

main([JSON|_]) :-
   name(JSON, Aeson),
   convert_to_movie_genre_terms(Aeson).

translators(Ts) :-
   map(translate, [itemLabel-title, genreLabel-genre, year-published], Ts).

convert_to_movie_genre_terms(JSON) :-
   json(array(Obj), JSON, []),
   translators(Translators),
   map(json_to_term(movie_genre, Translators), Obj, Terms),
   do(write_term, Terms).

sample('[{"item":"http://www.wikidata.org/entity/Q75823148",
         "itemLabel":"Cunningham",
         "genreLabel":"musical film",
         "year":"2019"},
        {"item":"http://www.wikidata.org/entity/Q75823148",
         "itemLabel":"Cunningham",
         "genreLabel":"musical film",
         "year":"2020"}]').

% Well! I never! Would you just look at this sample JSON, smh!

/*
... and ... HEEEEEEEre's what happened:

$ TEXT=`cat movie_db/etl/movie_genre.json`; ./convert_movie_genre $TEXT 
zsh: argument list too long: ./convert_movie_genre

because of this:

$ getconf ARG_MAX
262144

TIME TO PROCESS BY FILES, ... AND STUFF!

(and use, e.g.: RedShift and S3, mayhap, so we can break up large results
into batches).
*/
