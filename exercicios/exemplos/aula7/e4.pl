maximo_acc(L, Max) :- maximo_acc(L, -inf, Max).

maximo_acc([], Acc, Acc):- !.
maximo_acc([X|Xs], Acc, Max) :- X > Acc, maximo_acc(Xs, X, Max), !.
maximo_acc([_|Xs], Acc, Max) :- maximo_acc(Xs, Acc, Max), !.
