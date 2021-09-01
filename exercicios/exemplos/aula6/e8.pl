% TODO: Não funciona

% subconjuntos(+Conj, -SubConjs)

subconjuntos(Conj, [[F]|SubConjs]) :- [F|_]=Conj, bagof(SubC, ([_|SubC] = Conj), SubConjs).
