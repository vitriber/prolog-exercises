prefixo([], _).
prefixo([X|T1], [X|T2]) :- prefixo(T1, T2).

sufixo(L, L).
sufixo(L, [_|T]) :- sufixo(L, T).
