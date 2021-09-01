:- [e1].

permuta([], []).
permuta(L, [X|L1]) :- insere(X, L2, L), permuta(L2, L1).
