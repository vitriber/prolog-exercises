##### 1. Suponha que tenhamos uma coleção fpig de n sentenças na
lógica de predicados, em que i varia de 1 a n. Agora, considere
a conjunção
Vn
i=1 pi . O que essa expressão significa se n = 1?
E se n = 0? E se usarmos disjunção em vez de conjunção? Ou
seja, quais são os valores de verdade nulos para a conjunção e
a disjunção?

Resposta: Verdade, Falso, Todos os valores seriam falso

##### 2. Expresse um fato e sua negação como implicações.

:advogado(joão) _ rico(joão)
advogado(joão) _ garçom(joão)

##### 3. O axioma (8) diz que todo mundo tem uma casa. Isso é
realmente verdade?

Não é verdade.

##### 3.1. Qual é o objeto no mundo real que corresponde à função
casa_de(P)?
casa(casa_de(joão),joão)

##### 3.2. Como formalizar que João tem uma casa usando somente
predicados em vez de função?

casa(casa_de(joão),joão)

##### 4. Prove que Modus ponens é completa para bases de
conhecimento de Horn.

a1 ^ : : : ^ am ! b
ai
a1 ^ : : : ^ ai􀀀1 ^ ai+1 ^ : : : ^ am ! b

##### 5. Se F é uma sentença falsa, como a negação de uma tautologia,
por exemplo, prove que D  q é equivalente a D [ f:qg  F.

Definição: Modus ponens é a seguinte regra de inferência,
onde d = ai :