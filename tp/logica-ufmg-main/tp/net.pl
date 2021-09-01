/* Eis um exemplo de codigo, eu pode ser usado tal qual, modificado e etc,
utilizando soquetes. E para utilizar no TP2!
PS. Funciona no gprolog, garantidamente, ams pode conter um pequeno erro (ainda!)
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
envia_jogada(Conexao, X, Y, Z) :-
        Conexao = conexao(_, Entrada, Saida),
	envia(Saida, jogada(X, Y, Z)),
	read(Entrada, Resposta),
	(Resposta = aceita    ->
           format(user_output,
                  'Jogada (~d, ~d, ~d) enviada com sucesso.\n',
                  [X, Y, Z])
	% O adversario informou que a jogada enviada nao eh coerente.
	% Ele continuara esperando o envio de uma jogada valida.
         ; Resposta = recusada -> fail
	% O adversario retornou algo que nao faz parte do protocolo.
	% Tente outra vez.
         ; envia_jogada(Conexao, X, Y, Z)
        ).


:- [outra_tentativa].

run_local_player(Conexao) :- 
   board(B), 
   alpha_beta(o,3,B,-200,200,(X,Y,Z),_Value), 
   record(o,X,Y,Z), !,
   envia_jogada(Conexao, X, Y, Z).

run_remote_player(Conexao) :-
   recebe_jogada(Conexao, X, Y, Z),
   record(x,X,Y,Z), !.
