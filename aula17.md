#### 1. No exemplo de referência, use a resolução ordenada para encontrar que alguma coisa dá muito trabalho para limpar.


1. Seja L = f:qg, onde L é a lista de todas sentenças geradas
até agora.
2. Selecione um elemento p 2 L. Se p = V ! F, q foi provado,
retorne sucesso. Senão, se o primeiro literal em p pode ser
resolvido ou com a b.c. ou com algum elemento de L, faça-o e
adicione a resolvente a L. Se não há sentenças que resolvam
com p, remova-a de L.
3. Se L é vazia, retorne falha. Senão, vá para 2.

progenitor(P,F) ^ bem_sucedido(F,T) ^ casado(F,E) !
orgulhoso(P)