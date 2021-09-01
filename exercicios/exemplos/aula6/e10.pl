print_n(0, _):- !.
print_n(N, A) :- N1 is N-1, write(A), print_n(N1,A).

triangulo(0, _):- !.
triangulo(N, NMax) :- N1 is N-1, triangulo(N1, NMax), Stars is ((N-1)*2)+1, Spaces is NMax-N, print_n(Spaces, ' '), print_n(Stars, '*'), print_n(Spaces, ' '), nl.

triangulo(N) :- triangulo(N, N).