:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



test([[sucre,riz,ble],[cacao,cafe],[mais]]).

main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/


	plateauInit(Piles, Bourse, Pos),

	plateauDisplay(Piles, Bourse, Pos), nl,
	

	emptyList(J1),

	plateauAvancer(Piles, NewPiles, Pos, NewPos, 2, Elem1, Elem2),
	print('Avancé de 2'), nl,

	plateauDisplay(NewPiles, NewBourse, NewPos),


	jouer(J1, _ , Bourse, NewBourse, Elem1, Elem2),
	print('Garde de '), print(Elem1), print(', Vente de '), print(Elem2), nl,

	plateauDisplay(NewPiles, NewBourse, NewPos).


	/*test(Stocks),
	print(Stocks),
	prendrePion(Stocks, 2, NewStocks, Elem),
	print(Elem),
	print(NewStocks).*/

