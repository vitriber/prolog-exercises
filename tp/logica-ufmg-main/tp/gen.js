let linhas=[];

console.log(`% Representação do tabuleiro (os números são os índices da lista)
%
% 00|01|02|03  ||  04|05|06|07  ||  08|09|10|11  ||  12|13|14|15
% 16|17|18|19  ||  20|21|22|23  ||  24|25|26|27  ||  28|29|30|31
% 32|33|34|35  ||  36|37|38|39  ||  40|41|42|43  ||  44|45|46|47
% 48|49|50|51  ||  52|53|54|55  ||  56|57|58|59  ||  60|61|62|63`);


console.log(`:- dynamic board/1.

init:- 
   retractall(board(_)),
   assert(board([${Array(64).fill('_Z').map((v,i) => v+(i+1)).join(',')}])).
:- init.


%%%%%
%%  Record a move: record(+,+,+).
%%%%%
record(Player,X,Y,Z) :- 
   retract(board(B)), 
   mark(Player,B,X,Y,Z),
   assert(board(B)).


`)


console.log('\n\n% ======== Win lines ========\n');

linhas.push('\n% 2D Rows');
for(let i=0;i<16;i++){
    linhas.push([0+i*4,1+i*4,2+i*4,3+i*4]);
}
linhas.push('\n% 2D Cols');
for(let i=0;i<16;i++){
    linhas.push([0+i,16+i,32+i,48+i]);
}
linhas.push('\n% 2D Diags');
for(let i=0;i<4;i++){
    linhas.push([0+i*4,17+i*4,34+i*4,51+i*4])
}
for(let i=0;i<4;i++){
    linhas.push([3+i*4,18+i*4,33+i*4,48+i*4])
}

linhas.push('\n% 3D Holes');
for(let i=0;i<4;i++){
    for(let j=0;j<4;j++)
    linhas.push([16*i+0+j,16*i+4+j,16*i+8+j,16*i+12+j]);
}

linhas.push('\n% 3D Rows');
for(let i=0;i<4;i++){
    linhas.push([0+i*16, 5+i*16, 10+i*16, 15+i*16], [3+i*16, 6+i*16, 9+i*16, 12+i*16])
}

linhas.push('\n% 3D Cols');
for(let i=0;i<4;i++){
    linhas.push([0+i, 20+i, 40+i, 60+i], [12+i, 24+i, 36+i, 48+i])
}

linhas.push('\n% 3D Diags');
linhas.push([15,26,37,48],[12, 25,38,51],[3,22,41,60],[0,21,42,63])

console.log(linhas.map(o=>{
    if (typeof o === 'string') return o;
    let a = Array(o[3]).fill('_');
    a[o[0]]='Z1';
    a[o[1]]='Z2';
    a[o[2]]='Z3';
    a[o[3]]='Z4';
    let s = '[' + a.join(',');
    if (o[3] === 63) s += ']';
    else s += '|_]';
    return 'win(' + s + ',P) :- Z1==P, Z2==P, Z3==P, Z4==P, !.';
}).join('\n'));

console.log('\n\n% ======== Open lines ======== \n');

console.log(linhas.map(o=>{
    if (typeof o === 'string') return o;
    let a = Array(o[3]).fill('_');
    a[o[0]]='Z1';
    a[o[1]]='Z2';
    a[o[2]]='Z3';
    a[o[3]]='Z4';
    let s = '[' + a.join(',');
    if (o[3] === 63) s += ']';
    else s += '|_]';
    return 'open(' + s + ',P) :- (var(Z1) | Z1==P), (var(Z2) | Z2==P), (var(Z3) | Z3==P), (var(Z4) | Z4==P).';
}).join('\n'));

const getindex = (x,y,z) => 16*y+4*z+x;

console.log(`\n\n%%%%%\n%%  Move \n%%%%%`);

const getarr = (x,y,z) => '['+Array(getindex(x,y,z)+1).fill('X').map((_,i) => 'X'+(i+1)).join(',')+'|R], ['+Array(getindex(x,y,z)).fill('X').map((_,i) => 'X'+(i+1)).concat(['P']).join(',')+'|R]';

for(let y=0;y<4;y++)
    for(let z=0;z<4;z++)
        for(let x=0;x<4;x++)
            console.log(`move(P, (${x},${y},${z}), ${getarr(x,y,z)}) :- var(X${getindex(x,y,z)+1}).`);



console.log('\n\n%%%%%\n%%  Generate possible marks on a free spot on the board.\n%%  Use mark(+,+,-X,-Y) to query/generate possible moves (X,Y).\n%%%%%');
for(let y=0;y<4;y++)
    for(let z=0;z<4;z++)
        for(let x=0;x<4;x++)
            console.log(`mark(P, [${Array(getindex(x,y,z)).fill('_').concat(['X']).join(',')}|_],${x},${y},${z}) :- var(X), X=P.`);


console.log(`

%%%%%
%% Calculate the value of a position, o maximizes, x minimizes.
%%%%%
value(Board,100) :- win(Board,o), !.
value(Board,-100) :- win(Board,x), !.
value(Board,E) :- 
    findall(o,open(Board,o),MAX), 
    length(MAX,Emax),      % # lines open to o
    findall(x,open(Board,x),MIN), 
    length(MIN,Emin),      % # lines open to x
    E is Emax - Emin.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% using minimax procedure with alpha-beta cutoff.
% Computer (o) searches for best tic tac toe move, 
% Human player is x.
% Adapted from L. Sterling and E. Shapiro, The Art of Prolog, MIT Press, 1986.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
search(Position,Depth,(Move,Value)) :- 
   alpha_beta(o,Depth,Position,-100,100,Move,Value).

alpha_beta(_Player,0,Position,_Alpha,_Beta,_NoMove,Value) :- 
   value(Position,Value).

alpha_beta(Player,D,Position,Alpha,Beta,Move,Value) :- 
   D > 0, 
   findall((X,Y,Z),mark(Player,Position,X,Y,Z),Moves), 
   Alpha1 is -Beta, % max/min
   Beta1 is -Alpha,
   D1 is D-1, 
   evaluate_and_choose(Player,Moves,Position,D1,Alpha1,Beta1,nil,(Move,Value)).

evaluate_and_choose(Player,[Move|Moves],Position,D,Alpha,Beta,Record,BestMove) :-
   move(Player,Move,Position,Position1), 
   other_player(Player,OtherPlayer),
   alpha_beta(OtherPlayer,D,Position1,Alpha,Beta,_OtherMove,Value),
   Value1 is -Value,
   cutoff(Player,Move,Value1,D,Alpha,Beta,Moves,Position,Record,BestMove).
evaluate_and_choose(_Player,[],_Position,_D,Alpha,_Beta,Move,(Move,Alpha)).

cutoff(_Player,Move,Value,_D,_Alpha,Beta,_Moves,_Position,_Record,(Move,Value)) :- 
   Value >= Beta, !.
cutoff(Player,Move,Value,D,Alpha,Beta,Moves,Position,_Record,BestMove) :- 
   Alpha < Value, Value < Beta, !, 
   evaluate_and_choose(Player,Moves,Position,D,Value,Beta,Move,BestMove).
cutoff(Player,_Move,Value,D,Alpha,Beta,Moves,Position,Record,BestMove) :- 
   Value =< Alpha, !, 
   evaluate_and_choose(Player,Moves,Position,D,Alpha,Beta,Record,BestMove).

other_player(o,x).
other_player(x,o).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% For testing, use h(+,+) to record human move,
%%% supply coordinates. Then call c (computer plays).
%%% Use s to show board.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h(X,Y,Z) :- 
   record(x,X,Y,Z), !,
   showBoard.

c(D) :- 
   board(B), 
   alpha_beta(o,D,B,-200,200,(X,Y,Z),_Value), 
   record(o,X,Y,Z), !,
   showBoard.

c :- c(3).

showBoard([], _).
showBoard([C|Board], I) :- M is I mod 16, M =:= 15, mark(C), writeln(''), I1 is I + 1, showBoard(Board, I1), !.
showBoard([C|Board], I) :- M is I mod 4, M =:= 3, mark(C), write('  ||  '), I1 is I + 1, showBoard(Board, I1), !.
showBoard([C|Board], I) :- mark(C), write('|'), I1 is I + 1, showBoard(Board, I1), !.

showBoard :- board(Board), showBoard(Board, 0), (win(Board, x) -> format('~nx ganhou!~n',[]); (win(Board, o) -> format('~no ganhou!~n',[]); (full(Board) -> writeln('velha!')))), !.
s :- showBoard.

full([]).
full([X|Xs]) :- \\+var(X), full(Xs).

mark(X) :- 
   var(X),
   write('_').
mark(X) :- 
   \\+var(X),
   write(X).


`);