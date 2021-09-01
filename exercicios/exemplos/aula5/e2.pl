% classe(+Int, ?Classe)

classe(0, zero) :- !.
classe(X, Y) :- X < 0 -> Y=negativo; Y=positivo.
