unificavel([], _, []).
unificavel([X|Xs], Y, T) :- X\=Y, !, unificavel(Xs, Y, T).
unificavel([X|Xs], Y, [X|T]) :- unificavel(Xs, Y, T).
