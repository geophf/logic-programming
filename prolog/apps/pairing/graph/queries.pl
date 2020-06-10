:- ['utils/list'].
:- ['utils/str'].
:- ['utils/neo4j'].
:- ['utils/cypher'].
:- ['utils/str'].

:- ['apps/pairing/graph/admin'].

jigsawyers(DB, Members) :-
   query_graph_store(DB, ["MATCH (p:Jigsawyer:ACTIVE) RETURN p"], Response),
   Response = results(data(Rows), _, _),
   map(extract(name), Rows, Members).

/*
WITH the members, we need to compute the pairings and triplings Len // 2
meetings back.

HOW CAN THIS BE ACCOMPLISHED??? WOE IS ME!
*/

apriori(DB, Members, PreviousPairings) :-
   length(Members, Len),
   Meetns is Len // 2,
   Q0 = "MATCH (:Top)-[:AT]->(p1:Pairings)-[:FOLLOWING*1..",
   number_string(Meetns, M),
   Qn ="]->(ps:Pairings) RETURN p1, ps",
   str_cat([Q0, M, Qn], Query),
   query_graph_store(DB, [Query], PreviousPairings).

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
*/
