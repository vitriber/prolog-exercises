:- [e8].

% 9.1
max(X, Y, X) :- X >= Y.
max(X, Y, Y) :- Y > X.

% 9.2
mdc(X, X, X).
mdc(X, Y, Z) :- Y > X, mdc(Y, X, Z).
mdc(X, Y, Z) :- X =\= 0, Y =\= 0, M is X - Y, mdc(M, Y, Z).

% 9.3
max_lista([X|[]], X).
max_lista([X|L], Max) :- max_lista(L, Y), max(X, Y, Max).

% 9.4
soma_da_lista([X|[]], X).
soma_da_lista([X|L], Soma) :- soma_da_lista(L, S), Soma is X + S.

% 9.5
subsoma(Lista, Soma, Subconjunto) :- subconjunto(Lista, Subconjunto), soma_da_lista(Subconjunto, Soma).

% 9.6
intervalo(N1, N2, X) :- N1 < N2 - 2, N3 is N2 - 1, intervalo(N1, N3, X); N1 < N2 - 1, X is N2 - 1.

