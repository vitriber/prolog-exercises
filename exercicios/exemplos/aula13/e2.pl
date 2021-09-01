% Auxiliares
conc([], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

sublista([], _).
sublista(Xs, AsXsBs) :- conc(_As, XsBs, AsXsBs), conc(Xs, _Bs, XsBs), Xs \= [].

