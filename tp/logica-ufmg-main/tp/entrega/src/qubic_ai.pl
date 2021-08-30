:- [qubic].

possible_move(P, [n|Rest], [P|Rest]).
possible_move(P, [X|Rest], [X|Rest2]) :-
    possible_move(P, Rest, Rest2).

all_possible_moves(P, Board, AllMoves) :-
    findall(Move, possible_move(P, Board, Move), AllMoves).

eval_board([], Value) :-
    Value is 0.
eval_board(Board, Value) :-
    win_pos(x, Board),
    Value is 1, !.
eval_board(Board, Value) :-
    win_pos(o, Board),
    Value is -1, !.
eval_board(Board, Value) :-
    check_full(Board),
    Value is 0.

compare_moves(max, MoveA, ValueA, _, ValueB, MoveA, ValueA) :-
	ValueA >= ValueB.
compare_moves(max, _, ValueA, MoveB, ValueB, MoveB, ValueB) :-
	ValueA < ValueB.
compare_moves(min, MoveA, ValueA, _, ValueB, MoveA, ValueA) :-
	ValueA =< ValueB.
compare_moves(min, _, ValueA, MoveB, ValueB, MoveB, ValueB) :-
	ValueA > ValueB.

change_max_min(max, min).
change_max_min(min, max).

best_move(max, [], [], -2).
best_move(min, [], [], 2).
best_move(MinMax, [Move | RestMoves], BestMove, BestValue) :-
    eval_board(Move, Value),
    best_move(MinMax, RestMoves, CurrentBestM, CurrentBestV),
	compare_moves(MinMax, Move, Value, CurrentBestM, CurrentBestV, BestMove, BestValue).
best_move(MinMax, [Move | RestMoves], BestMove, BestValue) :-
	best_move(MinMax, RestMoves, CurrentBestM, CurrentBestV),
	change_max_min(MinMax, Other),
	minimax_step(Other, Move, _, BottomBestV),
	compare_moves(MinMax, Move, BottomBestV, CurrentBestM, CurrentBestV, BestMove, BestValue).


% minimax_step(+MinMax, +Board, -BestMove, -BestValue)
% Chooses the best possible move for the current board.
minimax_step(MinMax, Board, BestMove, BestValue) :-
	player(MinMax, Color),
	all_possible_moves(Color, Board, AllMoves),
    best_move(MinMax, AllMoves, BestMove, BestValue).



run_ai_player(Board, Player, NewBoard) :- 
    player(MinMax, Player),
    minimax_step(MinMax, Board, NewBoard, _).

run_ai_game(Board, Player) :- (
    print_status(Board)
    ;(
        run_ai_player(Board, Player, NewBoard) -> (
            change_player(Player, NewPlayer),
            run_ai_game(NewBoard, NewPlayer)
        ); (
            writeln('Movimento incorreto, tente novamente.\n'),
            run_ai_game(Board, Player)
        )
    )
).

game_ai(Board, FirstPlayer) :- run_ai_game(Board, FirstPlayer), !.
game_ai(FirstPlayer) :- player(_, FirstPlayer), make_board(Board), run_ai_game(Board, FirstPlayer), !.
game_ai(Board) :- player(max, FirstPlayer), run_ai_game(Board, FirstPlayer).

game_ai :- player(max, FirstPlayer), game_ai(FirstPlayer).
