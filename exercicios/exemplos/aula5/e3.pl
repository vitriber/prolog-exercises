% separa(+Inteiros,?Pos,?Neg)

separa1([], [], []).
separa1([X|Xs], [X|Pos], Neg) :- X >= 0, separa1(Xs, Pos, Neg).
separa1([X|Xs], Pos, [X|Neg]) :- X < 0, separa1(Xs, Pos, Neg).


separa2([], [], []).
separa2([X|Xs], [X|Pos], Neg) :- X >= 0, !, separa2(Xs, Pos, Neg).
separa2([X|Xs], Pos, [X|Neg]) :- separa2(Xs, Pos, Neg).
