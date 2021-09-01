let linhas=[];

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

