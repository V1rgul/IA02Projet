
marchandises([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).






genererPile(Marchandises, NewPile, NewMarchandises) :-
	emptyList(Pile),
	takeElement(Marchandises , E1, Marchandises2),
	takeElement(Marchandises2, E2, Marchandises3),
	takeElement(Marchandises3, E3, Marchandises4),
	takeElement(Marchandises4, E4, NewMarchandises),
	append(Pile , [E1], Pile2),
	append(Pile2, [E2], Pile3),
	append(Pile3, [E3], Pile4),
	append(Pile4, [E4], NewPile).

marchandisesDepart([[ble,6],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

genererPiles(NewPiles) :-
	marchandisesDepart(M),
	genererPile(M , P1, M1),
	genererPile(M1, P2, M2),
	genererPile(M2, P3, M3),
	genererPile(M3, P4, M4),
	genererPile(M4, P5, M5),
	genererPile(M5, P6, M6),
	genererPile(M6, P7, M7),
	genererPile(M7, P8, M8),
	genererPile(M8, P9, _),
	emptyList(Piles),
	append(Piles , [P1], Piles1),
	append(Piles1, [P2], Piles2),
	append(Piles2, [P3], Piles3),
	append(Piles3, [P4], Piles4),
	append(Piles4, [P5], Piles5),
	append(Piles5, [P6], Piles6),
	append(Piles6, [P7], Piles7),
	append(Piles7, [P8], Piles8),
	append(Piles8, [P9], NewPiles),
	!,
	print('Piles: '),
	print(NewPiles), nl.


initPlateau(Piles, Bourse) :-
	genererPiles(Piles),
	Bourse = [].