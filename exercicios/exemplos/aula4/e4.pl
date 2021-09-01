% nao_ocorre(+Elem, +Lista, -Nao_ocorre)

nao_ocorre(_, [], []) :- !.
nao_ocorre(Elem, [Elem|T], Ocorrencias) :- nao_ocorre(Elem, T, Ocorrencias), !.
nao_ocorre(Elem, [X|T], [X|Ocorrencias]) :- nao_ocorre(Elem, T, Ocorrencias).
