viz(albania,[grecia,macedonia,montenegro,servia, andorra|A]-A):-!.
viz(andorra,[franca,espanha|A]-A):-!.
viz(austria,[rep_tcheca,alemanha,hungria,italia,albania, liechtenstein,eslovaquia,eslovenia,suissa|A]-A):-!.
viz(_, A-A).

/* coleta(+Abertos,+Fechados,?Lista) é verdade sse
Lista é instanciada com a lista de todos os nós
de um grafo cíclico definido por viz/2. Abertos
contém um nó inicial. Fechados contém os nós já
coletados.
*/

coleta(Abertos-A,Fechados,Fechados):- Abertos == A, !.

coleta([No|Abertos]-A,Fechados,Lista):-
    member(No,Fechados),!,
    coleta(Abertos-A,Fechados,Lista).
coleta([No|Abertos]-A,Fechados,Lista):-
    viz(No,Vizs-B),
    A=Vizs,
    coleta(Abertos-B,[No|Fechados],Lista).

faz_lista(Lista):-
    coleta([andorra|A]-A,[],Lista).
