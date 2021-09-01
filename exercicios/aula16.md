#### 1. Compute o umg de p e q, simplificando ao máximo os resultados:
#### 1.1. p = f (g(V); h(U;V)) e q = f (g(W); h(W; j(X;Y ))).
V -> U:V W -> W: X:Y
U -> V
#### 1.2. p = f (g(V); h(U;V)) e q = f (g(W); h(W; j(X;U))).
V -> U:V F W -> XU
#### 1.3. p = f (X; f (U;X)) e q = f (f (Y ; a); f (Z; f (b; Z))).
X -> UX Z => Z
#### 1.4. p = j(f (X; g(X;Y )); h(Z;Y )) e q = j(Z; h(f (U;V); f (a; b))).
X -> Y
#### 2. Traduza para a lógica de 1a ordem e use a resolução para
#### encontrar 3 animais que os leões alcançam:
#### 2.1. Animais podem alcançar animais que eles comem.
#### 2.2. Carnívoros comem outros animais.
#### 2.3. Alcançar é transitiva: Se X alcança Y e Y alcança Z, então X alcança Z.
#### 2.4. Leões comem zebras.
#### 2.5. Zebras alcançam cães.
#### 2.6. Cães são carnívoros.

Zebras, Cães, Leões

#### 3. Use Prolog para responder as perguntas acima.