##### 1. Prove que a resolução é correta por contradição.

1 trabalho(cjoão))! F meta negada
2 grande(cjoão) ^ casa(cjoão,joão)! trabalho(cjoão) (??)
3 grande(cjoão) ^ casa(cjoão,joão)! F resolve ??, ??
4 V! casa(cjoão,joão) (??)
5 grande(cjoão)! F resolve ??, ??
6 casa(cjoão,joão) ^ rico(joão)! grande(cjoão) (??)
7 casa(cjoão,joão) ^ rico(joão)! F resolve ??,??
8 rico(joão)! F resolve ??, ??
9 advogado(joão)! rico(joão) (??)
10 advogado(joão)! F resolve ??, ??
11 V! advogado(joão) (??)
12 V! F resolve ??, ??

##### 2. Por que Prolog não tem a verdadeira negação? Dê 2 exemplos
de cláusulas que Prolog não aceita em sua base de
conhecimento que ilustrem sua resposta.

Prolog não pode fazer negação clássica. Uma vez que não usa inferência clássica. 
Mesmo na presença de conclusão de Clark, ele não pode detectar as seguintes duas leis clássicas:

p :- p

   ?- \+(p, \+p)

   ?- p; \+p

mother(X, Y) :-
    not(male(X)),
    parent(X, Y).

##### 3. Seja x um literal qualquer.
##### 3.1. Use a resolução para derivar x ^ x de x _ x.
1. Elimine ! usando p ! q  :p _ q.
2. Use a lei de de Morgan para que a negação só se aplique a
literais.
3. Distribua _ e ^ para escrever o resultado como uma conjunção
de disjunções.
4. Divida as conjunções.
5. Combine os termos negados.
6. Reintoduza ! para ter expressões da forma (??).
##### 3.2. A resolução pode derivar a conclusão acima sem fatoração?
Sim
##### 4. Traduza a seguinte frase em forma normal:
João é um advogado de júri se e somente se ele é, ou um
promotor, ou um advogado penal.

João <-> Advogado -> Promotor <> Advogado Penal