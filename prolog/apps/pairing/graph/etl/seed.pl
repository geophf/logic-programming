
% Seed data to initialize the graph-store.

member(len).
member(howie).
member(ray).
member(nicole).
member(morgan).
member(jose).
member(tony).
member(apoorv).
member(ken).
member(doug).
member(shoaib).

% week 1: may 21

week(1, 'May 21, 2020', List) :-
   % paired(date('May 21, 2020'), len, howie).   /* triple */
   % paired(date('May 21, 2020'), howie, tony).  /* triple */
   List = [paired(date('May 21, 2020'), ray, nicole),
           paired(date('May 21, 2020'), morgan, jose),
           paired(date('May 21, 2020'), shoaib, apoorv),
           paired(date('May 21, 2020'), ken, doug),
           triple(date('May 21, 2020'), [len, howie, tony])].

% week 2: may 28

week(2, 'May 28, 2020', List) :-
   % paired(date('May 28, 2020'), ray, shoaib).   /* triple */
   % paired(date('May 28, 2020'), shoaib, doug).  /* triple */
   List = [paired(date('May 28, 2020'), len, apoorv),
           paired(date('May 28, 2020'), morgan, nicole),
           paired(date('May 28, 2020'), howie, jose),
           paired(date('May 28, 2020'), ken, tony),
           triple(date('May 28, 2020'), [ray, shoaib, doug])].

% week 3: jun 04

week(3, 'June 4, 2020', List) :-
   % paired(date('June 4, 2020'),jose,apoorv).    /* triple */
   List = [paired(date('June 4, 2020'),len,ray),
           paired(date('June 4, 2020'),howie,nicole),
           paired(date('June 4, 2020'),morgan,tony),
           paired(date('June 4, 2020'),ken,shoaib),
           triple(date('June 4, 2020'),[doug,jose,apoorv])].

/*
week 4: jun 11 ... some things up in the air about this week:
Nicole was called away. Tony/Ray/Jose/Apoorv: unknown ... pair them all
together? idk.
*/

week(4, Date, List) :-
   Date = 'June 11, 2020',
   DD = date(Date),
   List = [paired(DD,ken,len),
           paired(DD,shoaib,morgan),

% ... so: pairs of pairs of pairs? nupe! Apoorv gave me the what's what.

           paired(DD,howie,apoorv),
           triple(DD,[ray,jose,tony])].