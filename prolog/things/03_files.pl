/*
DIS HEAHE IS FILE IO!

But, since we're on the cloud, and we're lambda-ing it up, or whatever,
let's also consider 'files' as stream, i.e.: S3 or some URL.

And also, we have to consider REST calls, eventually, don't we?

Yes. Yes, we do.

So, anyway: files FRIST!

read_sommat_from_dis_heahe_file_n_stupfen :-
   see(dis),
   do(dat),
   seen.

... right?
*/

yo.
foo.

/*
This problem came up because I can't process the movie_genres straight off,
but, mayhap, another approach would be to break the genre files up by year, and
then process each one of those.

Let's try that first before we go all file-y/socket-y crazy here, yes?
*/

% ...

/*
But to extract movies-by-year, we need to PROCESS movies-by-year, and wouldn't
that all be better if it were some part of automated process

generate_year -> build SPARQL -> query wikidata endpoint -> process films

... and in that case we have a multi-file fact-table to concern ourselves
with, now, don't we.

So ... hm. More thought required.
*/
