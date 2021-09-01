:- [e4].

sublista_p([], _).
sublista_p(Xs, AsXsBs) :- sufixo(XsBs, AsXsBs), prefixo(Xs, XsBs), Xs \= [].

sublista_s([], _).
sublista_s(Xs, AsXsBs) :- prefixo(AsXs, AsXsBs), sufixo(Xs, AsXs), Xs \= [].
