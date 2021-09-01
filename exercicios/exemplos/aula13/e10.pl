% se X>2 então Y:=1 senão Y:=2

se(entao(Cond, senao(Com1, Com2))) :- call(Cond) -> call(Com1); call(Com2).
':='(X, Y) :- X is Y.

:- op(993, fx, se).
:- op(992, xfx, entao).
:- op(991, xfx, senao).
:- op(990, xfx, ':=').
