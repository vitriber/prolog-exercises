% Tempo de execução do código original: 180ms
% Tempo de execução do código modificado: 51ms

% Há clara vantagem em tratar primeiro os casos com menos possibilidades de escolha,
% principalmente conforme o tamanho do problema aumenta.

alfametico([S,E,I,T,V,N]):-
    unifica([0,1,2,3,4,5,6,7,8,9],[V,S,E,I,T,N]),
    V \= 0,
    1000*S + 100*E + 10*I + S +
    1000*S + 100*E + 10*T + E +
    1000*S + 100*E + 10*T + E =:=
    10000*V + 1000*I + 100*N + 10*T + E.

unifica(_,[]).
unifica(Num,[N|Vars]):-
    del(N,Num,NumSemN),
    unifica(NumSemN,Vars).

del(X,[X|Xs],Xs).
del(Xs,[Y|Ys],[Y|Zs]):-
    del(Xs,Ys,Zs).

roda([S,E,I,S],[S,E,T,E],[S,E,T,E],[V,I,N,T,E]):-
    alfametico([S,E,I,T,V,N]).
