% adiciona_ao_fim(?DifLista,+Item,-NovaDifLista)
adiciona_ao_fim(L-A, Item, L-B) :- A = [Item|B].