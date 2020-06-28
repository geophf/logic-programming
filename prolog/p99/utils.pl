% some common utilities, but specific to p99 problems only!

p99_data_store('PROLOG_GRAPH').

p99_graph_connect(User, Pass, Endpoint) :-
   p99_data_store(DB),
   graph_connect_info(DB, User, Pass, Endpoint).
