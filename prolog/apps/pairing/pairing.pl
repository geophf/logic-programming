:- ['utils/list'].
:- ['utils/io'].
:- ['utils/cat'].

:- ['apps/pairing/graph/admin'].
:- ['apps/pairing/graph/queries'].
:- ['apps/pairing/graph/etl/uploader'].

/*
To see the pairings in the graph:

MATCH (:Top)-[:AT]->(p1:Pairings)-[:FOLLOWING*1..5]->(p2:Pairings) 
RETURN p1, collect(p2)
*/

pair_up(Date, Pairs) :-
   pair_up(Date, except([]), Pairs).

pair_up(Date, Excepts, Pairs) :-
   generate_pairs(Date, Excepts, Pairs),
   store_pairs(Date, Pairs),
   do(write_term,Pairs).

generate_pairs(Date, except(Nupes), Pairs) :-
   data_store(DB),
   pairing_context(DB, Context),
   Context = pairing_context(team_members(Members), pairings(History)),
   map1(enpairify(Date), Nupes, Zupes, History),

   /* I could do a series of triple/2 and pair/3 assertions here, but ... */

   pairs(Date, Members, Zupes, Pairs).

enpairify(Datus, Pairus, paired(date(Datus), P, Q)) :-
   unpair(Pairus, P, Q).

/*
?- generate_pairs('June 25, 2020', except([]), Pairs).
Pairs = [triple(date('June 25, 2020'), ['Apoorv', 'Ken', 'Nicole']), 
         paired(date('June 25, 2020'), 'Shoaib', 'Doug'), 
         paired(date('June 25, 2020'), 'Len', 'Howie'), 
         paired(date('June 25, 2020'), 'Ray', 'Morgan'), 
         paired(date('June 25, 2020'), 'Jose', 'Tony')] .

?- generate_pairs('June 25, 2020', except(['Ray' - 'Morgan']), Pairs).
Pairs = [triple(date('June 25, 2020'), ['Tony', 'Ken', 'Nicole']), 
         paired(date('June 25, 2020'), 'Shoaib', 'Doug'), 
         paired(date('June 25, 2020'), 'Len', 'Howie'), 
         paired(date('June 25, 2020'), 'Ray', 'Jose'), 
         paired(date('June 25, 2020'), 'Morgan', 'Apoorv')] .
*/

store_pairs(Date, Pairs) :-
   upload_pairings(Date, Pairs, Mtg),
   link_pairings(Mtg),
   write('... AAAAAANNNNNND ... we are done!'), nl.

/*
WITH the members, we need to compute the pairings and triplings Len // 2
meetings back.

HOW CAN THIS BE ACCOMPLISHED??? WOE IS ME!
*/

pairs(Date, Members, History, Pairs) :-
   pair_it(Members, History, P0, []),
   (delete(take_me(P), P0, P1) ->
      delete(paired(Q, R), P1, P2),
      not(in_triple(Q, History)),
      not(in_triple(R, History)),
      map(print_pair(date(Date)), P2, P3),
      Pairs = [triple(date(Date), [P, Q, R])|P3]
   ;
      map(print_pair(date(Date)), P0, Pairs)).

extract_triple([H|_], H) :-
   H = triple(date(_), _).
extract_triple([_|T], Triple) :-
   extract_triple(T, Triple).

in_triple(A, History) :-
   extract_triple(History, triple(_, Trip)),
   member(A, Trip).

extract_pair([H|_], A, B) :-
   H = paired(date(_), A, B).
extract_pair([_|T], A, B) :-
   extract_pair(T, A, B).

already_paired(A, B, History) :-
     extract_pair(History, A, B)
   ; extract_pair(History, B, A).

print_pair(Date, H, Term) :-
   H =.. [Fn, A, B],
   Term =.. [Fn, Date, A, B].

pair_it([], _) --> [].
pair_it([H], _) --> [take_me(H)].
pair_it([H|T], History) -->
   { delete(R, T, Q),
     not(already_paired(H, R, History)) },
   [paired(H, R)],
   pair_it(Q, History).
