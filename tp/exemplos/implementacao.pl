/* Eis um exemplo de codigo, eu pode ser usado tal qual, modificado e etc,
utilizando soquetes.
PS. Funciona no gprolog, garantidamente, mas pode conter um pequeno erro (ainda!)
Para funcionar remotamente, é preciso criar uma rede virtual com ZeroTier, por
exemplo: https://www.zerotier.com
*/

/***********************************************************************
 * O tipo abstrato 'conexao' encapsula tudo o que eh necessario para a
 * comunicacao entre os dois adversarios. O soquete eh mantido para
 * fechar a conexao ao termino do jogo. Os 'streams' de entrada e
 * saida proveem os meios de comunicar com o adversario enviando as
 * proprias jogadas e recebendo as jogadas desde.
 *                                                                  
 * conexao(Soquete, Stream_entrada, Stream_saida).                     
 ***********************************************************************/

 %%%%%
%%  Record a move: record(+,+,+).
%%%%%
record(Player,X,Y) :- 
   retract(board(B)), 
   mark(Player,B,X,Y),
   assert(board(B)).

%%%%%
%%  Generate possible marks on a free spot on the board.
%%  Use mark(+,+,-X,-Y) to query/generate possible moves (X,Y).
%%%%%
mark(Player, [X|_],1,1) :- var(X), X=Player.
mark(Player, [_,X|_],2,1) :- var(X), X=Player.
mark(Player, [_,_,X|_],3,1) :- var(X), X=Player.
mark(Player, [_,_,_,X|_],1,2) :- var(X), X=Player.
mark(Player, [_,_,_,_,X|_],2,2) :- var(X), X=Player.
mark(Player, [_,_,_,_,_,X|_],3,2) :- var(X), X=Player.
mark(Player, [_,_,_,_,_,_,X|_],1,3) :- var(X), X=Player.
mark(Player, [_,_,_,_,_,_,_,X|_],2,3) :- var(X), X=Player.
mark(Player, [_,_,_,_,_,_,_,_,X|_],3,3) :- var(X), X=Player.

%%%%%
%%  Move 
%%%%%
move(P,(1,1),[X1|R],[P|R]) :- var(X1).
move(P,(2,1),[X1,X2|R],[X1,P|R]) :- var(X2).
move(P,(3,1),[X1,X2,X3|R],[X1,X2,P|R]) :- var(X3).
move(P,(1,2),[X1,X2,X3,X4|R],[X1,X2,X3,P|R]) :- var(X4).
move(P,(2,2),[X1,X2,X3,X4,X5|R],[X1,X2,X3,X4,P|R]) :- var(X5).
move(P,(3,2),[X1,X2,X3,X4,X5,X6|R],[X1,X2,X3,X4,X5,P|R]) :- var(X6).
move(P,(1,3),[X1,X2,X3,X4,X5,X6,X7|R],[X1,X2,X3,X4,X5,X6,P|R]) :- var(X7).
move(P,(2,3),[X1,X2,X3,X4,X5,X6,X7,X8|R],[X1,X2,X3,X4,X5,X6,X7,P|R]) :- var(X8).
move(P,(3,3),[X1,X2,X3,X4,X5,X6,X7,X8,X9|R],[X1,X2,X3,X4,X5,X6,X7,X8,P|R]) :- var(X9).

%%%%% 
%%  A winning line is ALREADY bound to Player. 
%%  win(+Board,+Player) is true or fail.
%%    e.g., win([P,P,P|_],P).  is NOT correct, because could bind 
%%%%%
win([Z1,Z2,Z3|_],P) :- Z1==P, Z2==P, Z3==P.
win([_,_,_,Z1,Z2,Z3|_],P) :-  Z1==P, Z2==P, Z3==P.
win([_,_,_,_,_,_,Z1,Z2,Z3],P) :-  Z1==P, Z2==P, Z3==P.
win([Z1,_,_,Z2,_,_,Z3,_,_],P) :-  Z1==P, Z2==P, Z3==P.
win([_,Z1,_,_,Z2,_,_,Z3,_],P) :-  Z1==P, Z2==P, Z3==P.
win([_,_,Z1,_,_,Z2,_,_,Z3],P) :-  Z1==P, Z2==P, Z3==P.
win([Z1,_,_,_,Z2,_,_,_,Z3],P) :-  Z1==P, Z2==P, Z3==P.
win([_,_,Z1,_,Z2,_,Z3,_,_],P) :-  Z1==P, Z2==P, Z3==P.

%%%%%
%%  A line is open if each position is either free or equals the Player
%%%%%
open([Z1,Z2,Z3|_],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([_,_,_,Z1,Z2,Z3|_],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([_,_,_,_,_,_,Z1,Z2,Z3],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([Z1,_,_,Z2,_,_,Z3,_,_],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([_,Z1,_,_,Z2,_,_,Z3,_],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([_,_,Z1,_,_,Z2,_,_,Z3],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([Z1,_,_,_,Z2,_,_,_,Z3],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).
open([_,_,Z1,_,Z2,_,Z3,_,_],Player) :- (var(Z1) | Z1 == Player),(var(Z2) | Z2 == Player), (var(Z3) | Z3 == Player).


/***********************************************************************
 * conecta_adversario(+Nome_do_servidor, +Porto, -Conexao).
 *
 * Conecta com o servidor de nome e porto dados onde, supoem-se, um
 * adversario estara esperando por conexoes.
 ***********************************************************************/
conecta_adversario(Servidor, Porto, Conexao) :-
	tcp_socket(Soquete),
	tcp_connect(Soquete, Servidor:Porto), 
	tcp_open_socket(Soquete,Entrada,Saida),
        format(user_output,
               'Conectado com o servidor ~a na porta ~d.\n',
               [Servidor, Porto]),
	Conexao = conexao(Soquete, Entrada, Saida).

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

:- assert(lookahead(2)).
:- dynamic spy/0.  % debug calls to alpha_beta
:- assert(spy).    % Comment out stop spy.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
search(Position,Depth,(Move,Value)) :- 
   alpha_beta(o,Depth,Position,-100,100,Move,Value).

alpha_beta(Player,0,Position,_Alpha,_Beta,_NoMove,Value) :- 
   value(Position,Value),
   spy(Player,Position,Value).

alpha_beta(Player,D,Position,Alpha,Beta,Move,Value) :- 
   D > 0, 
   findall((X,Y),mark(Player,Position,X,Y),Moves), 
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

spy(Player,Position,Value) :- 
   spy, !,
   write(Player),
   write(' '),
   write(Position),
   write(' '),
   writeln(Value).
spy(_,_,_). % do nothing

/***********************************************************************
 * espera_conexao(+Porto, -Conexao).
 *
 * Espera que um adversario conecte no porto dado para que possa ser
 * iniciada uma nova partida.
 ***********************************************************************/
espera_adversario(Porto, Conexao) :-
	tcp_socket(Soquete),
	tcp_bind(Soquete,Porto),
	tcp_listen(Soquete, 0),
    tcp_open_socket(Soquete, Entrada1, _),
    tcp_accept(Entrada1, SoqueteCliente, EnderecoCliente),
    tcp_open_socket(SoqueteCliente,Entrada, Saida),
	tcp_host_to_address(Cliente, EnderecoCliente),
        format(user_output,
               'Recebida conexao do cliente ~a.\n',
               [Cliente]),
	Conexao = conexao(Soquete, Entrada, Saida).	 


/***********************************************************************
 * envia(+Conexao, +Termo).
 *
 * Envia o termo dado para o adversario usando o 'stream' de saida
 * dado.
 ***********************************************************************/
envia(Saida, Termo) :-
	write(Saida, Termo),
	write(Saida, .),
	nl(Saida),
	flush_output(Saida).


/***********************************************************************
 * recebe_jogada(+Conexao, -Coordenada_X, +Coordenada_Y,
 *               +Coordenada_Z).
 *
 * Recebe a jogada do adversario ao qual se esta conectado atraves da
 * conexao dada nas coordenadas (X, Y, Z).
 ***********************************************************************/
recebe_jogada(Conexao, X, Y, Z) :-
	Conexao = conexao(_, Entrada, Saida),
        ((read(Entrada, jogada(X, Y, Z)), valida_jogada(X, Y, Z)) ->
           (envia(Saida, aceita), 
            format(user_output,
                   'Recebida jogada (~d, ~d, ~d).\n',
                   [X, Y, Z])
           )
        % O adversario enviou algo que nao eh uma jogada valida ou
 	% nem mesmo eh uma jogada.
	% Espera ate que uma jogada correta seja enviada.
         ; (envia(Saida,recusada),
            recebe_jogada(Conexao, X, Y, Z)
           )
	).


/***********************************************************************
 * valida_jogada(+X, +Y, +Z) (IMPLEMENTACAO EH ABSTRATA).
 *
 * Verifica se a jogada recebida ja foi proposta por um dos jogadores
 * em jogadas anteriores. Isso evita que por acidente, uma jogada seja
 * repetida em uma rodada posterior.
 ***********************************************************************/
valida_jogada(X, Y, Z) :-
	X >= 0, X =< 3,
	Y >= 0, Y =< 3,
	Z >= 0, Z =< 3.
	% Resto da verificacao vem aqui.


/***********************************************************************
 * envia_jogada(+Conexao, -Coordenada_X, +Coordenada_Y,
 *              +Coordenada_Z).
 *
 * Envia a jogada nas coordenadas (X, Y, Z) para o adversario ao qual
 * se esta conectado atraves da conexao dada.
 ***********************************************************************/
envia_jogada(Conexao, X, Y) :-
        Conexao = conexao(_, Entrada, Saida),
	envia(Saida, jogada(X, Y)),
	read(Entrada, Resposta),
	(Resposta = aceita    ->
           format(user_output,
                  'Jogada (~d, ~d, ~d) enviada com sucesso.\n',
                  [X, Y])
	% O adversario informou que a jogada enviada nao eh coerente.
	% Ele continuara esperando o envio de uma jogada valida.
         ; Resposta = recusada -> fail
	% O adversario retornou algo que nao faz parte do protocolo.
	% Tente outra vez.
         ; envia_jogada(Conexao, X, Y)
        ).


% :- [outra_tentativa].

:- dynamic board/1.

init:- 
   retractall(board(_)),
   assert(board([_Z1,_Z2,_Z3,_Z4,_Z5,_Z6,_Z7,_Z8,_Z9en])).
:- init.

showBoard :- 
   board([Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9]), 
   write('    '),mark(Z1),write(' '),mark(Z2),write(' '),mark(Z3),nl,
   write('    '),mark(Z4),write(' '),mark(Z5),write(' '),mark(Z6),nl,
   write('    '),mark(Z7),write(' '),mark(Z8),write(' '),mark(Z9),nl.
s :- showBoard.

mark(X) :- 
   var(X),
   write('#').
mark(X) :- 
   \+var(X),
   write(X).

run_local_player(Conexao, X, Y) :- 
   board(B), 
   alpha_beta(o,3,B,-200,200,(X,Y),_Value), 
   record(o,X,Y), !,
   envia_jogada(Conexao, X, Y),
   showBoard.

run_remote_player(Conexao) :-
   recebe_jogada(Conexao, X, Y),
   record(x,X,Y), !.

run_network_game(Conexao, Player, RemotePlayer) :- (
   showBoard
   ;(
      (Player = RemotePlayer -> run_remote_player(Conexao); run_local_player(Conexao)) -> (
         other_player(Player, NewPlayer),
         run_network_game(Conexao, NewPlayer, RemotePlayer)
      ); (
         writeln('Movimento incorreto, tente novamente.\n'),
         run_network_game(Conexao, Player, RemotePlayer)
      )
   )
).


network_game(Conexao, FirstPlayer, RemotePlayer) :- run_network_game(Conexao, FirstPlayer, RemotePlayer).

host_game(Porto) :- format('Seu jogador é o "O"!~nAguardando conexão na porta ~d...~n', [Porto]), espera_adversario(Porto, Conexao), writeln('Conectado!'), network_game(Conexao, x, x).
join_game(Servidor, Porto) :- conecta_adversario(Servidor, Porto, Conexao), network_game(Conexao, x, o).