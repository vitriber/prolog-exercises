% Representação do tabuleiro (os números são os índices da lista)
%
% 00|01|02|03  ||  04|05|06|07  ||  08|09|10|11  ||  12|13|14|15
% 16|17|18|19  ||  20|21|22|23  ||  24|25|26|27  ||  28|29|30|31
% 32|33|34|35  ||  36|37|38|39  ||  40|41|42|43  ||  44|45|46|47
% 48|49|50|51  ||  52|53|54|55  ||  56|57|58|59  ||  60|61|62|63

check_4(Board, Player, A, B, C, D) :-
    nth0(A, Board, Player),
    nth0(B, Board, Player),
    nth0(C, Board, Player),
    nth0(D, Board, Player).

check_pos_row(Player, Index, Board) :- A is Index, B is Index+1, C is Index+2, D is Index+3,
    check_4(Board, Player, A, B, C, D).

check_pos_col(Player, Index, Board) :- R is Index mod 16, A is R, B is R+16, C is R+32, D is R+48,
    check_4(Board, Player, A, B, C, D).


check_pos_diag_p(Player, Index, Board) :- A is Index, B is A+17, C is A+34, D is A+51,
    check_4(Board, Player, A, B, C, D).


check_pos_diag_s(Player, Index, Board) :- A is Index, B is Index+15, C is Index+30, D is Index+45,
    check_4(Board, Player, A, B, C, D).

check_pos_furos3d(Player, Index, Board) :- A is Index, B is Index+4, C is Index+8, D is Index+12,
    check_4(Board, Player, A, B, C, D).

check_pos_row3d_rl(Player, Index, Board) :- A is Index, B is Index+5, C is Index+10, D is Index+15,
    check_4(Board, Player, A, B, C, D).

check_pos_row3d_lr(Player, Index, Board) :- A is Index, B is Index+3, C is Index+6, D is Index+9,
    check_4(Board, Player, A, B, C, D).

check_pos_col3d_ud(Player, Index, Board) :- A is Index, B is Index+20, C is Index+40, D is Index+60,
    check_4(Board, Player, A, B, C, D).

check_pos_col3d_du(Player, Index, Board) :- A is Index, B is Index-12, C is Index-24, D is Index-36,
    check_4(Board, Player, A, B, C, D).

check_pos(Player, Index, Board) :- M is Index mod 4, M =:= 0, check_pos_row(Player, Index, Board).
check_pos(Player, Index, Board) :- Index < 16, check_pos_col(Player, Index, Board).
check_pos(Player, Index, Board) :- Index < 16, M is Index mod 4, M =:= 0, check_pos_diag_p(Player, Index, Board).
check_pos(Player, Index, Board) :- Index < 16, M is Index mod 4, M =:= 3, check_pos_diag_s(Player, Index, Board).

check_pos(Player, Index, Board) :- M is Index mod 16, M < 4, check_pos_furos3d(Player, Index, Board).

check_pos(Player, Index, Board) :- M is Index mod 16, M =:= 0, check_pos_row3d_rl(Player, Index, Board).
check_pos(Player, Index, Board) :- M is Index mod 16, M =:= 3, check_pos_row3d_lr(Player, Index, Board).

check_pos(Player, Index, Board) :- Index < 4, check_pos_col3d_ud(Player, Index, Board).
check_pos(Player, Index, Board) :- Index > 47, Index < 52, check_pos_col3d_du(Player, Index, Board).

% 4 diagonais 3d finais
check_pos(Player, _, [Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player]).
check_pos(Player, _, [_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_]).
check_pos(Player, _, [_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_]).
check_pos(Player, _, [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]).

is_player(x).
is_player(o).


player(max, x).
player(min, o).

change_player(x, o).
change_player(o, x).

change_minmax(max, min).
change_minmax(min, max).

player_value(x, 1).
player_value(o, 1).
player_value(n, 0).

check_full([]).
check_full([C|Board]) :- is_player(C), check_full(Board).

win_pos(P, Board) :- nth0(I, Board, P), is_player(P), check_pos(P, I, Board), !.

is_end_game(Board, x) :- win_pos(x, Board), !.
is_end_game(Board, o) :- win_pos(o, Board), !.
is_end_game(Board, n) :- check_full(Board).


is_end_game_value(Board, Value) :-
    is_end_game(Board, Player),
    player_value(Player, Value).
    

get_index(X, Y, Z, Index) :- Index is 16*Y+X+4*Z.

% set_pos(+OldBoard, +Index, +Player, -NewBoard)
set_pos([C|Board], 0, Player, [Player|Board]) :- \+ is_player(C), !.
set_pos([C|Board], Index, Player, [C|NewBoard]) :- Index > 0, I is Index - 1, set_pos(Board, I, Player, NewBoard).

write_pos(C) :- is_player(C) -> write(C); write('_').

print_board([], _).
print_board([C|Board], I) :- M is I mod 16, M =:= 15, write_pos(C), writeln(''), I1 is I + 1, print_board(Board, I1), !.
print_board([C|Board], I) :- M is I mod 4, M =:= 3, write_pos(C), write('  ||  '), I1 is I + 1, print_board(Board, I1), !.
print_board([C|Board], I) :- write_pos(C), write('|'), I1 is I + 1, print_board(Board, I1).

print_board(Board) :- print_board(Board, 0).

print_winner(x) :- writeln('      >>>>>    X venceu o jogo!    <<<<<'), !.
print_winner(o) :- writeln('      >>>>>    O venceu o jogo!    <<<<<'), !.
print_winner(_) :- writeln('      >>>>>        Empatou!        <<<<<').

print_status(Board) :-
    print_board(Board),
    is_end_game(Board, P) -> print_winner(P), writeln(''); writeln(''), fail.

make_board([], 0):- !.
make_board([n|Board], I) :- I1 is I - 1, make_board(Board, I1).
make_board(Board) :- make_board(Board, 64).

run_player(Board, Player, NewBoard) :- 
    format('Player ~w, qual sua jogada?~n', [Player]),
    prompt1('X: '),
    read(X),
    prompt1('Y: '),
    read(Y),
    prompt1('Z: '),
    read(Z),
    get_index(X, Y, Z, Index),
    set_pos(Board, Index, Player, NewBoard).


run_game(Board, Player) :- (
    print_status(Board)
    ;(
        run_player(Board, Player, NewBoard) -> (
            change_player(Player, NewPlayer),
            run_game(NewBoard, NewPlayer)
        ); (
            writeln('Movimento incorreto, tente novamente.\n'),
            run_game(Board, Player)
        )
    )
).

run_game_ia(Board, Player) :- (
    print_status(Board)
    ;(
        (
            player(max, Player) -> (
                run_player_ia(Board, Player, NewBoard)
            ); (
                run_player(Board, Player, NewBoard)
            )
        ) -> (
            change_player(Player, NewPlayer),
            run_game_ia(NewBoard, NewPlayer)
        ); (
            writeln('Movimento incorreto, tente novamente.\n'),
            run_game_ia(Board, Player)
        )
    )
).

game(FirstPlayer) :- make_board(Board), run_game(Board, FirstPlayer).
game :- player(max, FirstPlayer), game(FirstPlayer).

game_ia :- make_board(Board), run_game_ia(Board, o).

get_possible_moves([], _, []).
get_possible_moves([n|Board], I, [I|Moves]) :- I1 is I+1, get_possible_moves(Board, I1, Moves), !.
get_possible_moves([_|Board], I, Moves) :- I1 is I+1, get_possible_moves(Board, I1, Moves).
get_possible_moves(Board, Moves) :- get_possible_moves(Board, 0, Moves).


run_player_ia(Board, Player, NewBoard) :- 
    alpha_beta_step(max, Board, 3, BestMove, _),
    print_move(BestMove),
    set_pos(Board, BestMove, Player, NewBoard).

best_move(_Player, _Board, [], _NewBoard, -2).
best_move(Player, Board, [Move|TailMoves], NewBoard, Value) :- 
    set_pos(Board, Move, Player, NewBoard),
    best_move(Player, Board, TailMoves, NewBoard, Value).


% alpha_beta_value()

% alpha_beta([], _, _, _, max, -2).
% alpha_beta([], _, _, _, min, 2).
% alpha_beta([Board|TailBoards], Depth, Alpha, Beta, MinMax, Value) :-
%     is_end_game_value(Board, Value)
%     ; (
%         MinMax = max -> (
%             MaxEval = -1,
%             D1 is Depth - 1,
%             change_minmax(MinMax, MinMax2),

%             alpha_beta(TailBoards, D1, Alpha, Beta, MinMax2, Value2),

            
%         ); (
%             Value is 2
%         )
%     ).


% compare_moves(+MinMax, +Move1, +Value1, +Move2, +Value2, -BestMove, -BestValue).
compare_moves(max, Move1, Value1, _Board2, Value2, Move1, Value1) :- Value1 >= Value2, !.
compare_moves(max, _Board1, Value1, Move2, Value2, Move2, Value2) :- Value1 <  Value2, !.
compare_moves(min, Move1, Value1, _Board2, Value2, Move1, Value1) :- Value1 <  Value2, !.
compare_moves(min, _Board1, Value1, Move2, Value2, Move2, Value2) :- Value1 >= Value2, !.

best_move_ab(max, _, [], _, _, _, -1, -2) :- !.
best_move_ab(min, _, [], _, _, _, -1, 2) :- !.
best_move_ab(max, Board, [Move|TMove], Depth, Alpha, Beta, BestMove, BestValue) :-
    player(max, Player),
    set_pos(Board, Move, Player, NewBoard),
    is_end_game_value(NewBoard, Value), !,
    Alpha1 is max(Alpha, Value),
    (Beta =< Alpha1 -> (BestMove = Move, BestValue = Value); (
        best_move_ab(max, Board, TMove, Depth, Alpha1, Beta, CurrentBestB, CurrentBestV),
        compare_moves(max, Move, Value, CurrentBestB, CurrentBestV, BestMove, BestValue)
    )).

best_move_ab(min, Board, [Move|TMove], Depth, Alpha, Beta, BestMove, BestValue) :-
    player(min, Player),
    set_pos(Board, Move, Player, NewBoard),
    is_end_game_value(NewBoard, Value), !,
    Beta1 is min(Beta, Value),
    (Beta =< Alpha -> (BestMove = Move, BestValue = Value); (
        best_move_ab(min, Board, TMove, Depth, Alpha, Beta1, CurrentBestB, CurrentBestV),
        compare_moves(min, Move, Value, CurrentBestB, CurrentBestV, BestMove, BestValue)
    )).

best_move_ab(_MinMax, _Board, [Move], Depth, _Alpha, _Beta, Move, 0) :-
    Depth = 0, !.

best_move_ab(MinMax, Board, [Move|TMove], Depth, Alpha, Beta, BestMove, BestValue) :-
    best_move_ab(MinMax, Board, TMove, Depth, Alpha, Beta, CurrentBestM, CurrentBestV),
    change_minmax(MinMax, Other),
    D1 is Depth - 1,
    player(MinMax, Player),
    set_pos(Board, Move, Player, NewBoard),
    alpha_beta_step(Other, NewBoard, D1, _, BottomBestV),
    compare_moves(MinMax, Move, BottomBestV, CurrentBestM, CurrentBestV, BestMove, BestValue).


alpha_beta_step(MinMax, Board, Depth, BestMove, BestValue) :-
	get_possible_moves(Board, AllMoves),
    best_move_ab(MinMax, Board, AllMoves, Depth, -2, 2, BestMove, BestValue).

alpha_beta(Board, BestMove) :-
	alpha_beta_step(max, Board, 64, BestMove, _).


get_move(Index, X, Y, Z) :-
    X is ((Index mod 16) mod 4),
    Y is floor(Index / 16),
    Z is (floor(Index / 4) mod 4).

print_move(Index) :-
    get_move(Index, X, Y, Z),
    format('X: ~d, Y: ~d, Z: ~d ~n', [X, Y, Z]).











valor(1,1).

alfa_beta(Arv,Valor) :-
    ab_minimax(Arv, -inf, inf, Valor).

ab_minimax(max(E,[]),_,_,Vlr):-
    valor(E,Vlr).

ab_minimax(min(E,[]),_,_,Vlr):-
    valor(E,Vlr).

ab_minimax(max(_E,Filhos),Alpha,Beta,Valor):-
    ab_max_filhos(Filhos,Alpha,Beta,-inf,Valor).

ab_minimax(min(_E,Filhos),Alpha,Beta,Valor):-
    ab_min_filhos(Filhos,Alpha,Beta,inf,Valor).


ab_max_filhos([],_,_,Max,Max).

ab_max_filhos([F|Fs], Alpha, Beta, Max1, Max) :-
    ab_minimax(F,Alpha,Beta,Valor),
    (
        Valor > Beta -> %corte Beta : não trata Fs
        Max=Beta
        ; (
            max(Valor,Alpha,Alpha1), %atualiza Alpha
            max(Valor,Max1,Max2),
            ab_max_filhos(Fs,Alpha1,Beta,Max2,Max)
        )
    ).

ab_min_filhos([],_,_,Min,Min).
ab_min_filhos([F|Fs],Alpha,Beta,Min1,Min):-
ab_minimax(F,Alpha,Beta,Valor),
( Alpha > Valor -> %corte Alpha: não trata Fs
Min=Alpha
; min(Valor,Beta,Beta1), %atualiza Beta
min(Valor,Min1,Min2),
ab_min_filhos(Fs,Alpha,Beta1,Min2,Min)
).