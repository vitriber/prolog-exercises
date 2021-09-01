% simplifica(+Expressao, -Simples)

simplifica(X, X) :- atomic(X).

% simplifica(E, X) :- E=..[F,A1,A2], .