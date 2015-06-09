:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



test([[sucre,riz,ble],[cacao,cafe],[mais]]).

spy.

main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/


	plateauInit(Piles, Bourse, Pos),

	plateauDisplay(Piles, Bourse, Pos), nl,
	

	emptyList(J1),

	plateauAvancer(Piles, Piles2, Pos, Pos2, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles2, Pos2),

	plateauAvancer(Piles2, Piles3, Pos2, Pos3, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles3, Pos3),

	plateauAvancer(Piles3, Piles4, Pos3, Pos4, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles4, Pos4),

	plateauAvancer(Piles4, Piles5, Pos4, Pos5, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles5, Pos5),

	plateauAvancer(Piles5, Piles6, Pos5, Pos6, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles6, Pos6),

	plateauAvancer(Piles6, Piles7, Pos6, Pos7, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles7, Pos7),

	plateauAvancer(Piles7, Piles8, Pos7, Pos8, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles8, Pos8),

	plateauAvancer(Piles8, Piles9, Pos8, Pos9, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles9, Pos9),

	plateauAvancer(Piles9, Piles10, Pos9, Pos10, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles10, Pos10),

	plateauAvancer(Piles10, Piles11, Pos10, Pos11, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles11, Pos11),

	plateauAvancer(Piles11, Piles12, Pos11, Pos12, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles12, Pos12),

	plateauAvancer(Piles12, Piles13, Pos12, Pos13, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles13, Pos13),

	plateauAvancer(Piles13, Piles14, Pos13, Pos14, 2, _, _),
	print('Avance de 2'), nl,
	printPiles(Piles14, Pos14),



	/*jouer(J1, _ , Bourse, NewBourse, Elem1, Elem2),
	print('Garde de '), print(Elem1), print(', Vente de '), print(Elem2), nl,*/

	plateauDisplay(NewPiles, NewBourse, NewPos).


	/*test(Stocks),
	print(Stocks),
	prendrePion(Stocks, 2, NewStocks, Elem),
	print(Elem),
	print(NewStocks).*/

