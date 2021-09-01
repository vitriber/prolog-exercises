membro(X,[X|_]).
membro(X,[_|L]) :- membro(X,L).

% sobra (+Candidatos, +Excluidos, -Saida)
sobra([], _, []).
sobra([X|Xs], Excluidos, [X|R]) :- \+ membro(X, Excluidos), !, sobra(Xs, Excluidos, R).
sobra([_|Xs], Excluidos, R) :- sobra(Xs, Excluidos, R).
