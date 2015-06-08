:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



test([[sucre,riz,ble],[cacao,cafe],[mais]]).

main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/


	plateauInit(Stocks, Bourse, Pos),
	plateauDisplay(Stocks, Bourse, Pos),

	decrement(Stocks, sucre, NewStocks),
	plateauDisplay(NewStocks, Bourse, Pos).

	/*test(Stocks),
	afficherBourse(Stocks),
	prendrePion(Stocks, 1, NewStocks, Elem),
	write(Elem),
	afficherBourse(NewStocks).*/
