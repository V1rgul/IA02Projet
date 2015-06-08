:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/

	plateauInit(Stocks, Bourse, Pos),
	plateauDisplay(Stocks, Bourse, Pos),



	decrement(Stocks, sucre, NewStocks),
	plateauDisplay(NewStocks, Bourse, Pos).
