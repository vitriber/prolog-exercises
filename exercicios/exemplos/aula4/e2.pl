% todas_ocorrencias(+Elem, +Lista, -Ocorrencias)

todas_ocorrencias(_, [], []) :- !.
todas_ocorrencias(Elem, [Elem|T], [Elem|Ocorrencias]) :- todas_ocorrencias(Elem, T, Ocorrencias), !.
todas_ocorrencias(Elem, [_|T], Ocorrencias) :- todas_ocorrencias(Elem, T, Ocorrencias).
