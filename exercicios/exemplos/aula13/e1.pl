% Auxiliares
conc([], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).



% 1.1
lista([]).
lista([_|X]) :- lista(X).

% 1.2
tam([], 0).
tam([_|X], Y) :- tam(X, Z), Y is Z + 1.

% 1.3
tam_par(X) :- tam(X, Y), Y mod 2 =:= 0.
tam_ímpar(X) :- tam(X, Y), Y mod 2 =:= 1.

% 1.4
inverte([], Acc, Acc).
inverte([X|L1], L2, Acc) :- inverte(L1, L2, [X|Acc]).
inverte(L1, L2) :- inverte(L1, L2, []).

% 1.5
del(X, [X|L], L).
del(X, [Y|L1], [Y|L2]) :- del(X,L1,L2).
insere(X, L, Res) :- del(X, Res, L).

% 1.6
roda([], []).
roda([X|L], L2) :- conc(L, [X], L2).

% 1.7
achata([], []).
achata([X|L], [X|L1]) :- \+ lista(X), achata(L, L1).
achata([X|L], L1) :- lista(X), conc(X, L, L1).

% 1.8
tamanho_igual([], []).
tamanho_igual([_|L1], [_|L2]) :- tamanho_igual(L1, L2).

% 1.9
divide_lista([], [], []).
divide_lista(AsBs, As, Bs) :- conc(As, Bs, AsBs), tamanho_igual(As, Bs).
divide_lista(AsBs, As, Bs) :- conc(As, Bs, AsBs), tam(As, X), tam(Bs, Y), Z is Y + 1, X =:= Z.

