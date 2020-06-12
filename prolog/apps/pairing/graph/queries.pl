:- ['utils/list'].
:- ['utils/str'].
:- ['utils/neo4j'].
:- ['utils/cypher'].
:- ['utils/str'].

:- ['apps/pairing/graph/admin'].

pairing_context(DB, pairing_context(team_members(Members), pairings(Pears))) :-
   jigsawyers(DB, Members),
   apriori(DB, Members, Dates),
   map(date2pairings(DB), Dates, Pairs),
   flatten(Pairs, Pears)).

date2pairings(DB, Date, Pairings) :-
   pairings_on(DB, Date, P0),
   (triple_on(DB, Date, Trip) -> Pairings = [Trip|P0] ; Pairings = P0).

/*
?- data_store(DB), pairing_context(DB, PC).
DB = 'TEAM_PAIRING',
PC = pairing_context(team_members(['Len', 'Howie', 'Nicole', 'Morgan'|...]),
                     pairings([triple(date('June 4, 2020'), ['Apoorv'|...]),
                               paired(date('June 4, 2020'), 'Len', 'Ray')|...]))
*/

jigsawyers(DB, Members) :-
   query_graph_store(DB, ["MATCH (p:Jigsawyer:ACTIVE) RETURN p"], Response),
   Response = results(data(Rows), _, _),
   map(extract(name), Rows, Members).

/*
WITH the members, we need to compute the pairings and triplings Len // 2
meetings back.

HOW CAN THIS BE ACCOMPLISHED??? WOE IS ME!
*/

apriori(DB, Members, PreviousPairingDates) :-
   length(Members, Len),
   Meetns is Len // 2,
   Q0 = "MATCH (:Top)-[:AT]->(p1:Pairings)-[:FOLLOWING*1..",
   number_string(Meetns, M),
   Qn ="]->(ps:Pairings) RETURN p1, collect(ps)",
   str_cat([Q0, M, Qn], Query),
   % query_graph_store(DB, [Query], PreviousPairings).  % nupe

/*
... and here we get stuck because Data returned for p1, collect(ps) is:

Data = [row=[json([date='June 4, 2020']), 
             [json([date='May 28, 2020']), json([date='May 21, 2020'])]],
        meta=[json([id=81, type=node, deleted= @(...)]), 
              json([id=32, type=node, ... = ...]), 
              json([id=80, ... = ...|...])]]

... and p1, ps also doesn't work:

Data = [json([row=[json([date='June 4, 2020']), 
                   json([date='May 28, 2020'])], 
              meta=[json([id=81, ... = ...|...]), json([... = ...|...])]]), 
        json([row=[json([date='June 4, 2020']), json([... = ...])], 
              meta=[json([... = ...|...]), json([...|...])]])] 

So, a 'short-term,' 'temporary' fix is to work with* the shape of the data
returned here.

*work around, actually.

But we do know the shape of the data returned from the shape of the values
RETURN'd, so ...

eh. anywayz. ('anyways' is not a word, btw)
*/

   store_graph_helper(DB, [Query], Response),
   Response = json([results=[json([_, data=[json(Data)]])],_]),
   Data = [row=[JDate1, JDates], _Meta],
   map(extract_date, [JDate1|JDates], PreviousPairingDates).

extract_date(json([date=Date]), Date).

/*
?- data_store(DB), jigsawyers(DB, M), apriori(DB, M, PPD).
DB = 'TEAM_PAIRING',
M = ['Len', 'Howie', 'Ray', 'Nicole', 'Morgan', 'Jose', 'Tony', 'Apoorv'|...],
PPD = ['June 4, 2020', 'May 28, 2020', 'May 21, 2020'] .
*/


/*
Now, with the previous pairing dates (PPD) we can get the pairings for each
date and the triples for each date, ... if'n triples there be!
*/

thingie(Date, Thing, Moar, Query) :-
   Q0 = "MATCH (p1:Jigsawyer)-[:",
   atom_string(Date, D),
   Q1 = """}]->(p2) RETURN p1",
   List = [Q0, Thing, " { on: """, D, Q1|Moar],
   str_cat(List, Query).

pairings_on(DB, Date, Pairings) :-
   thingie(Date, "PAIRED", [", p2"], Query),
   store_graph_helper(DB, [Query], Response),
   % ... some other stuff to get to:
   Response=json([results=[json([_Columns, data=Data])], _Errors]),
   map(row_to_pair(Date), Data, Pairings).

row_to_pair(Date, json([row=Row, meta=_Meta]), paired(date(Date), N1, N2)) :-
   map(extract(name), Row, [N1, N2]).

/*
?- data_store(DB), pairings_on(DB, 'June 4, 2020', Pairings).
DB = 'TEAM_PAIRING',
Pairings = [paired(date('June 4, 2020'), 'Len', 'Ray'), 
            paired(date('June 4, 2020'), 'Howie', 'Nicole'), 
            paired(date('June 4, 2020'), 'Morgan', 'Tony'), 
            paired(date('June 4, 2020'), 'Ken', 'Shoaib')] 
*/

% Now, tripling, because triples form a cycle, are actually easier!

triple_on(DB, Date, triple(date(Date), Names)) :-
   thingie(Date, "TRIPLED", [], Query),
   query_graph_store(DB, [Query], results(data(Trips), _, _)),
   map(extract(name), Trips, Names).

/*
Triple-structure is:
           triple(date('June 4, 2020'),[doug,jose,apoorv])].
*/
