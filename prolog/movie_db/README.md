# movie_db

In things/, We got readin'
We got ritin'
We got some 'rithmetic.

Now we want to do what prolog does: relatin'.

The problem with over-complicating queries to wikidata is that you get to
combinatory explosion, fast. A simple movie-genre query for 2019 returns
900 rows, but you add actors and directors into the mix, and the query now
returns 8000 rows, ... many of which are redundant, but not duplicate-redundant,
but indirectly-redundant.

So I was going to go on this 'filter out facts that can be proved to be
redundant from previous facts.' But I was also all like: "collect results
into a lisp."

... sorry: "list."

Prolog is a great list-processor, but so is lisp and haskell, so: so what and
who cares? Where prolog excels is in the relational calculus.

So?

So, why not use that and create tables and the build relations in your
queries. You know: prolog is a relational data store with a declarative
query engine.

Wait: am I talking about Prolog? Or am I talking about an RDS?

"Yes."

So. First: simplify this query:

```SPARQL
SELECT DISTINCT ?item ?itemLabel ?genreLabel ?directorLabel ?starringLabel 
                (year(xsd:dateTime(?pubdate)) as ?year) WHERE {
  ?item wdt:P31 wd:Q11424.
  ?item wdt:P577 ?pubdate.
  ?item wdt:P495 wd:Q30.
  ?item wdt:P364 wd:Q1860.
  ?item wdt:P136 ?genre. 
  ?item wdt:P577 ?pubdate. 
  ?item wdt:P57 ?director.
  ?item wdt:P161 ?starring.
  FILTER((?pubdate >= "2010-01-01T00:00:00Z"^^xsd:dateTime) 
      && (?pubdate <= "2020-12-31T00:00:00Z"^^xsd:dateTime))
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
}
```

... by removing the directors and starring relations, and then, instead building
one mongo (eheh) fact-table, build three separate ones, and then answer some
queries, below.

The SPARQL-JSON-to-Prolog-Fact-tables-converters are separate programs under
this domain, so

movie_genre
movie_director
movie_starring (sometimes known as actor)

Then, after we build those, we come back here, import those fact tables, and
do some knowledge engineering. YAY!

## Huffman?

The movie JSON files are megabytes. Of course, git compresses the files it stores
(did you know that?), but ... "maybe" we can use my ol' Huffman encoder to 
compress/decompress/recompress/phicompress these files?

Hm.
