% inverte(+Lista, +Acc, ?ListaInvertida)
inverte([X|Xs], Acc, Ys) :- var(Xs), Ys=[X|Acc], !.
inverte([X|Xs], Acc, Ys) :- inverte(Xs, [X|Acc], Ys).

% inverte(+Lista, ?ListaInvertida)
inverte(L1-A, L2-A) :- var(L1) -> L2=L1; inverte(L1, A, L2).