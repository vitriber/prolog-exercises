% Auxiliares
conc([], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

sublista([], _).
sublista(Xs, AsXsBs) :- conc(AsXs, _Bs, AsXsBs), conc(_As, Xs, AsXs), Xs \= [].

