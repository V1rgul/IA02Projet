emptyList([]).
marchandises([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).



/*
afficherListe([]).
afficherListe([T|Q]) :-
	write(T),
	afficherListe(Q).

afficherBourse :-
	write('Voici les cours de la bourses').

changerValeur(Stocks, Value, Add, NewStocks) :-
	Value is Add,
	NewStocks is Stocks.


main :-
	marchandises(Marchand),
	afficherListe(Marchand).

do(take(X)) :- !, take(X).
do(X) :- print("unknown command:"), print(X), nl.

take(X) :-
	print('take:'), print(X), nl.

%*/




random_member(L, E) :-
    length(L, S),
    random(0, S, I),
    nth0(I, L, E).

reduceNumber([_,0], NULL).
reduceNumber([E,N], [E, O]) :-
	O is N-1.
	

takeElement(Marchandises, Elem, NewMarchandises) :-
	random_member(Marchandises, E),
	delete(Marchandises, E, Marchandises2),
	reduceNumber(E, NewE),
	append(Marchandises2, [NewE], NewMarchandises),
	[Elem, _] = NewE.

genererPile(Marchandises, NewPile, NewMarchandises) :-
	emptyList(Pile),
	takeElement(Marchandises , E1, Marchandises2),
	append(Pile , [E1], Pile2),
	takeElement(Marchandises2, E2, Marchandises3),
	append(Pile2, [E2], Pile3),
	takeElement(Marchandises3, E3, Marchandises4),
	append(Pile3, [E3], Pile4),
	takeElement(Marchandises4, E4, NewMarchandises),
	append(Pile4, [E4], NewPile).

genererPiles :-
	marchandises(M),
	genererPile(M, P, _),
	print(P).