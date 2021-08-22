% Questão 10.1

%connected(+Start, +Goal, -Weight)
connected(1,7,1).
connected(1,8,1).
connected(1,3,1).
connected(7,4,1).
connected(7,20,1).
connected(7,17,1).
connected(8,6,1).
connected(3,9,1).
connected(3,12,1).
connected(9,19,1).
connected(4,42,1).
connected(20,28,1).
connected(17,10,1).

connected2(X,Y,D) :- connected(X,Y,D).
connected2(X,Y,D) :- connected(Y,X,D).

next_node(Current, Next, Path) :-
    connected2(Current, Next, _),
    not(member(Next, Path)).


% Questão 10.1.1

% Busca em profundidade

% ?- prof_iter(NósIni,0,Sol). % NósIni é a lista de nós iniciais
% prof_iter(NósIni,Prof,Sol) :-
% p_i(NósIni,NósIni,Prof,Sol).
% p_i([],NósIni,Prof,Sol) :- % Já visitou os nós até o nível Prof
% Prof1 is Prof + 1, % Itera a profundidade
% prof_iter(NósIni,Prof1,Sol). % Verifica os NósIni à Prof+1
% p_i([N|Nós],NósIni,Prof,[N]) :-
% solução(N). % O nó N é solução
% p_i([N|Nós],NósIni,Prof,Sol) :-
% profundidade(N,ProfN), % Determina profundidade do nó N
% ProfN <= Prof, % N está a uma prof. menor que Prof
% expande(N,Filhos), % então, expande seus filhos
% conc(Filhos,Nós,NovosNós), % Faz a procura em profundidade 1o,
% p_i(NovosNós,NósIni,Prof,Sol).
% p_i([_|Nós],NósIni,Prof,Sol) :-
% p_i(Nós,NósIni,Prof,Sol). % O 1o. nó é folha e não é solução

depth_first(Goal, Goal, _, [Goal]).
depth_first(Start, Goal, Visited, [Start|Path]) :-
    next_node(Start, Next_node, Visited),
    write(Visited), nl,
    depth_first(Next_node, Goal, [Next_node|Visited], Path).


% Busca em Largura

bfs(Res) :- start(Start), empty_queue(EQ),
  queue_append(EQ,[e(Start,[])],Q1),
  bfs1(Q1,Res).

bfs1(Queue,Res) :- queue_cons(e(Next,Path),NQ,Queue),
   bfs2(Next,Path,NQ,Res).

bfs2(H,Path,_NQ,Res) :- goal(H), reverse([H|Path],Res).
bfs2(H,Path,NQ,Res) :-  
              findall(e(Succ,[H|Path]),
                      (s(H,Succ),\+ member(Succ,Path)),AllSuccs),
              queue_append(NQ,AllSuccs,NewQueue),
              bfs1(NewQueue,Res).

% Questão 10.2.1

%connected(+Start, +Goal, -Weight)
connected(1,7,1).
connected(1,8,1).
connected(1,3,1).
connected(7,4,1).
connected(7,20,1).
connected(7,17,1).
connected(8,6,1).
connected(3,9,1).
connected(3,12,1).
connected(9,19,1).
connected(4,42,1).
connected(20,28,1).
connected(17,10,1).

connected2(X,Y,D) :- connected(X,Y,D).
connected2(X,Y,D) :- connected(Y,X,D).

next_node(Current, Next, Path) :-
    connected2(Current, Next, _),
    not(member(Next, Path)).


% Questão 10.1.2

% Busca em profundidade

% ?- prof_iter(NósIni,0,Sol). % NósIni é a lista de nós iniciais
% prof_iter(NósIni,Prof,Sol) :-
% p_i(NósIni,NósIni,Prof,Sol).
% p_i([],NósIni,Prof,Sol) :- % Já visitou os nós até o nível Prof
% Prof1 is Prof + 1, % Itera a profundidade
% prof_iter(NósIni,Prof1,Sol). % Verifica os NósIni à Prof+1
% p_i([N|Nós],NósIni,Prof,[N]) :-
% solução(N). % O nó N é solução
% p_i([N|Nós],NósIni,Prof,Sol) :-
% profundidade(N,ProfN), % Determina profundidade do nó N
% ProfN <= Prof, % N está a uma prof. menor que Prof
% expande(N,Filhos), % então, expande seus filhos
% conc(Filhos,Nós,NovosNós), % Faz a procura em profundidade 1o,
% p_i(NovosNós,NósIni,Prof,Sol).
% p_i([_|Nós],NósIni,Prof,Sol) :-
% p_i(Nós,NósIni,Prof,Sol). % O 1o. nó é folha e não é solução

depth_first(Goal, Goal, _, [Goal]).
depth_first(Start, Goal, Visited, [Start|Path]) :-
    next_node(Start, Next_node, Visited),
    write(Visited), nl,
    depth_first(Next_node, Goal, [Next_node|Visited], Path).


% Busca em Largura

bfs(Res) :- start(Start), empty_queue(EQ),
  queue_append(EQ,[e(Start,[])],Q1),
  bfs1(Q1,Res).

bfs1(Queue,Res) :- queue_cons(e(Next,Path),NQ,Queue),
   bfs2(Next,Path,NQ,Res).

bfs2(H,Path,_NQ,Res) :- goal(H), reverse([H|Path],Res).
bfs2(H,Path,NQ,Res) :-  
              findall(e(Succ,[H|Path]),
                      (s(H,Succ),\+ member(Succ,Path)),AllSuccs),
              queue_append(NQ,AllSuccs,NewQueue),
              bfs1(NewQueue,Res).