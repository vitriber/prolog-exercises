% passeia_cavalo(PosAtual, Dimensao, Salto, Tabuleiro) :- 

gera(Fim, Fim, [Fim]) :- !.

gera(N, Fim, [N|Ns]) :- 
    N < Fim,
    N1 is N+1,
    gera(N1, Fim, Ns), !.

gera(0, []):- !.
gera(S, [0|T]) :- S1 is S-1, gera(S1, T).


passeia_cavalo(PosAtual, Dimensao, Salto, Tabuleiro) :- 
    N is Dimensao * 2,
    I is (N div 7),
    J is (N mod 7),
    


% percorre_tab(Dimensao, Tabuleiro) :- 
%     gera(Dimensao, Tabuleiro).