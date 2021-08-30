%%%%%
%%  Record a move: record(+,+,+).
%%%%%
record(Player,X,Y,Z) :- 
    retract(board(B)), 
    mark(Player,B,X,Y,Z),
    assert(board(B)).


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
search(Position,Depth,(Move,Value)) :- 
   alpha_beta(o,Depth,Position,-100,100,Move,Value).

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
%%% For testing, use h(+,+) to record human move,
%%% supply coordinates. Then call c (computer plays).
%%% Use s to show board.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h(X,Y,Z) :- 
   record(x,X,Y,Z), !,
   showBoard.

c(D) :- 
   board(B), 
   alpha_beta(o,D,B,-200,200,(X,Y,Z),_Value), 
   record(o,X,Y,Z), !,
   showBoard.

c :- c(3).

showBoard([], _).
showBoard([C|Board], I) :- M is I mod 16, M =:= 15, mark(C), writeln(''), I1 is I + 1, showBoard(Board, I1), !.
showBoard([C|Board], I) :- M is I mod 4, M =:= 3, mark(C), write('  ||  '), I1 is I + 1, showBoard(Board, I1), !.
showBoard([C|Board], I) :- mark(C), write('|'), I1 is I + 1, showBoard(Board, I1), !.

showBoard :- board(Board), showBoard(Board, 0), (win(Board, x) -> format('~nx ganhou!~n',[]); (win(Board, o) -> format('~no ganhou!~n',[]); (full(Board) -> writeln('velha!')))), !.
s :- showBoard.

full([]).
full([X|Xs]) :- \+var(X), full(Xs).

mark(X) :- 
   var(X),
   write('_').
mark(X) :- 
   \+var(X),
   write(X).

