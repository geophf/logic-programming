% Seed data to initialize the graph-store.

member(len).
member(howie).
member(ray).
member(morgan).
member(jose).
member(apoorv).
member(ken).
member(doug).
member(shoaib).
member(victor).
member(elaine).
member(zack).

ex_member(roxi).
ex_member(nicole).
ex_member(robert).
ex_member(kate).
ex_member(tony).

week(1, Date, [triple(date(Date), [len, howie, tony])|List]) :-
   Date = 'May 21, 2020',
   pair_builder(Date, "ray morgan shoaib ken",
                      "nicole jose apoorv doug", List).

week(2, Date, [triple(date(Date), [ray, shoaib, doug])|List]) :-
   Date = 'May 28, 2020',
   pair_builder(Date, "len morgan howie ken",
                      "apoorv nicole jose tony", List).

week(3, Date, [triple(date(Date),[doug,jose,apoorv])|List]) :-
   Date = 'June 4, 2020',
   pair_builder(Date, "len howie morgan ken",
                      "ray nicole tony shoaib", List).

week(4, Date, [triple(date(Date),[ray,jose,tony])|List]) :-
   Date = 'June 11, 2020',
   pair_builder(Date, "ken shoaib howie", "len morgan apoorv", List).

week(5, Date, List) :- 
   Date = 'June 18, 2020',
   pair_builder(Date, "ray howie shoaib ken", 
                      "tony apoorv morgan len", List).

week(6, Date, List) :-
   Date = 'June 25, 2020',
   pair_builder(Date, "ray jose ken apoorv doug",
                      "morgan tony howie nicole shoaib", List).

% no slow-back July 2, as that was a short week.

week(7, Date, List) :-
   Date = 'July 9, 2020',
   pair_builder(Date, "doug ray nicole", "kate jose tony", List).

week(8, Date, List) :-
   Date = 'July 16, 2020',
   pair_builder(Date, "ray tony ken shoaib len",
                      "nicole apoorv doug robert howie", List).

week(9, Date, List) :-
   Date = 'July 23, 2020',
   pair_builder(Date, "apoorv jose robert howie shoaib",
                      "doug len ray nicole tony", List).

week(10, Date, List) :-
   Date = 'July 30, 2020',
   pair_builder(Date, "doug tony ray howie", "robert morgan ken apoorv", List).

week(11, Date, List) :-
   Date = 'August 6, 2020',
   pair_builder(Date, "tony apoorv doug len", "ken shoaib ray morgan", List).

week(12, Date, List) :-
   Date = 'August 13, 2020',
   pair_builder(Date,
                "len howie jose tony ken",
                "ray morgan apoorv doug shoaib",
                List).

week(13, Date, [triple(date(Date), [len, victor, tony])|List]) :-
   Date = 'August 27, 2020',
   pair_builder(Date, "howie morgan apoorv doug", "ray jose ken shoaib", List).

week(14, Date, Pairs) :-
   Date = 'September 10, 2020',
   pair_builder(Date, "howie ray morgan ken", "jose apoorv shoaib doug", Pairs).

week(15, Date, [triple(date(Date),[apoorv, victor, len])|Pairs]) :-
   Date = 'September 17, 2020',
   pair_builder(Date, "howie ray jose", "shoaib morgan ken", Pairs).

week(16, Date, Pairs) :-
   Date = 'September 24, 2020',
   pair_builder(Date, "len ray morgan ken apoorv",
                      "howie shoaib jose victor doug",
                Pairs).

week(17, Date, [triple(date(Date),[shoaib,doug,ray])|Pairs]) :-
   Date = 'October 1, 2020',
   pair_builder(Date, "ken zack jose elaine",
                      "morgan len apoorv victor", Pairs).

pair_builder(Date, Frists, Secnods, List) :-
   words(Frists, As),
   words(Secnods, Bs),
   zip_with(pairu(Date), As, Bs, List).

pairu(DD, A, B, paired(date(DD), A1, B1)) :-
   atom_string(A1, A),
   atom_string(B1, B).
