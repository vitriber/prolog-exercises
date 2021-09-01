% dif_conj(+Conj1, +Conj2, ?Dif).

membro(X,[X|_]).
membro(X,[_|L]) :- membro(X,L).

dif_conj([], _, []).
dif_conj([X|Xs], Excluidos, [X|Sobra]) :- \+ membro(X, Excluidos), !, dif_conj(Xs, Excluidos, Sobra).
dif_conj([_|Xs], Excluidos, Sobra) :- dif_conj(Xs, Excluidos, Sobra).
