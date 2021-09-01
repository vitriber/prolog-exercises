tabuadas :-
    L = [0,1,2,3,4,5,6,7,8,9],
    member(X,L),
    member(Y,L),
    Z is X*Y,
    assertz(produto(X,Y,Z)),
    fail.
tabuadas.

:- tabuadas.

% Questão 6
:- retractall((produto(_,_,_))).

% Questão 6.1
:- retractall((produto(_,_,0))).
