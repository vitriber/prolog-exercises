make_board([], 0):- !.
make_board([_|Board], I) :- I1 is I - 1, make_board(Board, I1).
make_board(Board) :- make_board(Board, 64). 

%%%%%
%% Calculate the value of a position, o maximizes, x minimizes.
%%%%%
value(Board,100) :- win(Board,o), !.
value(Board,-100) :- win(Board,x), !.
value(Board,E) :- 
    findall(o,open(Board,o),MAX), 
    length(MAX,Emax),      % # lines open to o
    findall(x,open(Board,x),MIN), 
    length(MIN,Emin),      % # lines open to x
    E is Emax - Emin.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% using minimax procedure with alpha-beta cutoff.
% Computer (o) searches for best tic tac toe move, 
% Human player is x.
% Adapted from L. Sterling and E. Shapiro, The Art of Prolog, MIT Press, 1986.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O código abaixo foi modificado a partir do disponível em https://www.cpp.edu/~jrfisher/www/prolog_tutorial/5_3.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha_beta(_Player,0,Position,_Alpha,_Beta,_NoMove,Value) :- 
   value(Position,Value).

alpha_beta(Player,D,Position,Alpha,Beta,Move,Value) :- 
   D > 0, 
   findall((X,Y,Z),mark(Player,Position,X,Y,Z),Moves), 
   Alpha1 is -Beta, % max/min
   Beta1 is -Alpha,
   D1 is D-1, 
   evaluate_and_choose(Player,Moves,Position,D1,Alpha1,Beta1,nil,(Move,Value)).

evaluate_and_choose(Player,[Move|Moves],Position,D,Alpha,Beta,Record,BestMove) :-
   move(Player,Move,Position,Position1), 
   other_player(Player,OtherPlayer),
   alpha_beta(OtherPlayer,D,Position1,Alpha,Beta,_OtherMove,Value),
   Value1 is -Value,
   cutoff(Player,Move,Value1,D,Alpha,Beta,Moves,Position,Record,BestMove).
evaluate_and_choose(_Player,[],_Position,_D,Alpha,_Beta,Move,(Move,Alpha)).

cutoff(_Player,Move,Value,_D,_Alpha,Beta,_Moves,_Position,_Record,(Move,Value)) :- 
   Value >= Beta, !.
cutoff(Player,Move,Value,D,Alpha,Beta,Moves,Position,_Record,BestMove) :- 
   Alpha < Value, Value < Beta, !, 
   evaluate_and_choose(Player,Moves,Position,D,Value,Beta,Move,BestMove).
cutoff(Player,_Move,Value,D,Alpha,Beta,Moves,Position,Record,BestMove) :- 
   Value =< Alpha, !, 
   evaluate_and_choose(Player,Moves,Position,D,Alpha,Beta,Record,BestMove).

other_player(o,x).
other_player(x,o).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O código acima foi modificado a partir do disponível em https://www.cpp.edu/~jrfisher/www/prolog_tutorial/5_3.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

showBoard([], _).
showBoard([C|Board], I) :- M is I mod 16, M =:= 15, mark(C), writeln(''), I1 is I + 1, showBoard(Board, I1), !.
showBoard([C|Board], I) :- M is I mod 4, M =:= 3, mark(C), write('  ||  '), I1 is I + 1, showBoard(Board, I1), !.
showBoard([C|Board], I) :- mark(C), write('|'), I1 is I + 1, showBoard(Board, I1), !.

showBoard(Board) :- showBoard(Board, 0), (win(Board, x) -> format('~nX ganhou!~n',[]); (win(Board, o) -> format('~nO ganhou!~n',[]); (full(Board) -> writeln('Velha!')))), !.

full([]).
full([X|Xs]) :- \+var(X), full(Xs).

mark(X) :- 
   var(X),
   write('_').
mark(X) :- 
   \+var(X),
   write(X).

