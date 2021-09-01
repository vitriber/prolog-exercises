% insere_li(?Item, +Last)
insere_li(Item, Last) :- var(Last), !, Last = [Item|_].
insere_li(Item, [_|L]) :- insere_li(Item, L).


% Pelos meus testes, o predicado não tem nenhuma restrição de uso.