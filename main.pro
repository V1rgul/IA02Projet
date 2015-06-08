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


	decrement(Bourse, sucre, NewBourse),
	print('Sucre vendu'), nl, nl,


	plateauDisplay(Piles, NewBourse, Pos).


	/*test(Stocks),
	afficherBourse(Stocks),
	prendrePion(Stocks, 1, NewStocks, Elem),
	write(Elem),
	afficherBourse(NewStocks).*/

