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

check_full([]).
check_full([C|Board]) :- is_player(C), check_full(Board).

win_pos(P, Board) :- nth0(I, Board, P), is_player(P), check_pos(P, I, Board), !.

is_end_game(Board, x) :- win_pos(x, Board), !.
is_end_game(Board, o) :- win_pos(o, Board), !.
is_end_game(Board, n) :- check_full(Board).

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


player(max, x).
player(min, o).

change_player(x, o).
change_player(o, x).

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

game(FirstPlayer) :- make_board(Board), run_game(Board, FirstPlayer).
game :- player(max, FirstPlayer), game(FirstPlayer).
