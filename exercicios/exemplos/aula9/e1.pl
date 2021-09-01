% [1,[2,[4,[8,[],[11]],[9]],[5]],[3,[6,[10],[]],[7]]]

% 1.1
% mostra(+Árvore)
mostra(Arv) :- mostra(Arv, 0).

write_t(0) :- !.
write_t(N) :- write('  '), N1 is N-1, write_t(N1).

mostra([], _).
mostra([X|Xs], Depth) :-
    write_t(Depth),
    writeln(X),
    D1 is Depth + 1,
    mostra_filhos(Xs, D1).

mostra_vazio(Depth) :- write_t(Depth), writeln('[]').

mostra_filhos([], _):- !.
mostra_filhos([X,Y], Depth) :- (X == [] -> mostra_vazio(Depth); mostra(X, Depth)), (Y == [] -> mostra_vazio(Depth); mostra(Y, Depth)).

:- mostra([1,[2,[4,[8,[],[11]],[9]],[5]],[3,[6,[10],[]],[7]]]).


% 1.2


mostra_1(Arv) :- mostra_1(Arv, 0).
mostra_1([], _).
mostra_1([X],Depth) :- write_t(Depth), writeln(X).
mostra_1([X,L,R], Depth) :-
    D1 is Depth + 1,
    write_t(Depth), writeln(X), % Centro
    (L == [] -> mostra_vazio(D1); mostra_1(L, D1)), % Esquerda
    (R == [] -> mostra_vazio(D1); mostra_1(R, D1)). % Direita


mostra_2(Arv) :- mostra_2(Arv, 0).
mostra_2([], _).
mostra_2([X],Depth) :- write_t(Depth), writeln(X).
mostra_2([X,L,R], Depth) :-
    D1 is Depth + 1,
    (L == [] -> mostra_vazio(D1); mostra_2(L, D1)), % Esquerda
    write_t(Depth), writeln(X), % Centro
    (R == [] -> mostra_vazio(D1); mostra_2(R, D1)). % Direita

mostra_3(Arv) :- mostra_3(Arv, 0).
mostra_3([], _).
mostra_3([X],Depth) :- write_t(Depth), writeln(X).
mostra_3([X,L,R], Depth) :-
    D1 is Depth + 1,
    (L == [] -> mostra_vazio(D1); mostra_3(L, D1)), % Esquerda
    (R == [] -> mostra_vazio(D1); mostra_3(R, D1)), % Direita
    write_t(Depth), writeln(X). % Centro

:- writeln('%%%%%%% 1.2.1').

:- mostra_1([
    1,
    [
        2,
        [
            4,
            [
                8,
                [],
                [11]
            ],
            [9]
        ],
        [5]
    ],
    [
        3,
        [
            6,
            [10],
            []
        ],
        [7]
    ]
]).

:- writeln('%%%%%%% 1.2.2').

:- mostra_2([
    1,
    [
        2,
        [
            4,
            [
                8,
                [],
                [11]
            ],
            [9]
        ],
        [5]
    ],
    [
        3,
        [
            6,
            [10],
            []
        ],
        [7]
    ]
]).

:- writeln('%%%%%%% 1.2.3').

:- mostra_3([
    1,
    [
        2,
        [
            4,
            [
                8,
                [],
                [11]
            ],
            [9]
        ],
        [5]
    ],
    [
        3,
        [
            6,
            [10],
            []
        ],
        [7]
    ]
]).
