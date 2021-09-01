:- [e1].

subconjunto(_, []).
subconjunto(Conjunto, [X|Subconjunto]) :- del(X, Conjunto, L1), subconjunto(L1, Subconjunto).
