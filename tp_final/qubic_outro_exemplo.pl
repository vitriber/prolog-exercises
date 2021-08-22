vencer(Hashtag, Jogada) :- vencer_linha(Hashtag, Jogada);
                  vencer_coluna(Hashtag, Jogada);
                  vencer_diagonal(Hashtag, Jogada).

vencer_linha(Hashtag, Jogada) :- Hashtag = [Jogada,Jogada,Jogada,_,_,_,_,_,_];
                   Hashtag = [_,_,_,Jogada,Jogada,Jogada,_,_,_];
		   Hashtag = [_,_,_,_,_,_,Jogada,Jogada,Jogada].

vencer_coluna(Hashtag, Jogada) :- Hashtag = [Jogada,_,_,Jogada,_,_,Jogada,_,_];
                   Hashtag = [_,Jogada,_,_,Jogada,_,_,Jogada,_];
		   Hashtag = [_,_,Jogada,_,_,Jogada,_,_,Jogada].

vencer_diagonal(Hashtag, Jogada) :- Hashtag = [Jogada,_,_,_,Jogada,_,_,_,Jogada];
		   Hashtag = [_,_,Jogada,_,Jogada,_,Jogada,_,_].

/* condições para vencer por linha, coluna e diagonal */

omove([1,B,C,D,E,F,G,H,I], Jogada, [Jogada,B,C,D,E,F,G,H,I]).
omove([A,2,C,D,E,F,G,H,I], Jogada, [A,Jogada,C,D,E,F,G,H,I]).
omove([A,B,3,D,E,F,G,H,I], Jogada, [A,B,Jogada,D,E,F,G,H,I]).
omove([A,B,C,4,E,F,G,H,I], Jogada, [A,B,C,Jogada,E,F,G,H,I]).
omove([A,B,C,D,5,F,G,H,I], Jogada, [A,B,C,D,Jogada,F,G,H,I]).
omove([A,B,C,D,E,6,G,H,I], Jogada, [A,B,C,D,E,Jogada,G,H,I]).
omove([A,B,C,D,E,F,7,H,I], Jogada, [A,B,C,D,E,F,Jogada,H,I]).
omove([A,B,C,D,E,F,G,8,I], Jogada, [A,B,C,D,E,F,G,Jogada,I]).
omove([A,B,C,D,E,F,G,H,9], Jogada, [A,B,C,D,E,F,G,H,Jogada]).

xmove([1,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,2,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,3,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,4,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,5,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,6,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,7,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,8,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,9], 9, [A,B,C,D,E,F,G,H,x]).
xmove(Hashtag, _, Hashtag) :- write('Movimento Ilegal'), nl.
/* Esses fatos se refere quando o X coloca uma jogada fora do intervalo de 1 a 9. 
 imprimir([A,B,C,D,E,F,G,H,I]) :- 
	write([A,B,C,D,E,F,G,H,I]),nl,nl. */


start(Hashtag,_,_) :- vencer(Hashtag, x), write('Voce venceu!').
start(Hashtag,_,_) :- vencer(Hashtag, o), write('Maquina Venceu!').
start(Hashtag,N,NovoHashtagNovo) :- xmove(Hashtag, N, NovoHashtag),jogadaO(NovoHashtag, NovoHashtagNovo).


paraXVencer(Hashtag) :- omove(Hashtag, x, NovoHashtag), vencer(NovoHashtag, x).

jogadaO(Hashtag,NovoHashtag) :- omove(Hashtag, o, NovoHashtag),vencer(NovoHashtag, o),!.
jogadaO(Hashtag,NovoHashtag) :- omove(Hashtag, o, NovoHashtag),not(paraXVencer(NovoHashtag)).
jogadaO(Hashtag,NovoHashtag) :- omove(Hashtag, o, NovoHashtag).
jogadaO(Hashtag,NovoHashtag) :- not(member([1,2,3,4,5,6,7,8,9],Hashtag)),!, write('Empate'), nl, NovoHashtag = Hashtag. 