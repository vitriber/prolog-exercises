% freq_nao_ocorre(+Elem, +Lista, -Freq)

:- [e4].

tamanho([], 0).
tamanho([_|L], S) :- tamanho(L, S1), S is S1 + 1.

freq_nao_ocorre1(Elem, Lista, Freq) :- nao_ocorre(Elem, Lista, F), tamanho(F, Freq).


freq_nao_ocorre2(_, [], Acc, Acc):- !.
freq_nao_ocorre2(Elem, [Elem|T], S, Acc) :- freq_nao_ocorre2(Elem, T, S, Acc), !.
freq_nao_ocorre2(Elem, [_|T], S, Acc) :- S1 is Acc + 1, freq_nao_ocorre2(Elem, T, S, S1).
freq_nao_ocorre2(Elem, Lista, Freq) :- freq_nao_ocorre2(Elem, Lista, Freq, 0).
