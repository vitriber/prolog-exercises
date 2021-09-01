% frequencia(+Elem, +Lista, -Frequencia)

:- [e2].

tamanho([], 0).
tamanho([_|L], S) :- tamanho(L, S1), S is S1 + 1.

frequencia1(Elem, Lista, Frequencia) :- todas_ocorrencias(Elem, Lista, F), tamanho(F, Frequencia).


frequencia2(_, [], Acc, Acc):- !.
frequencia2(Elem, [Elem|T], S, Acc) :- S1 is Acc + 1, frequencia2(Elem, T, S, S1), !.
frequencia2(Elem, [_|T], S, Acc) :- frequencia2(Elem, T, S, Acc).
frequencia2(Elem, Lista, Frequencia) :- frequencia2(Elem, Lista, Frequencia, 0).
