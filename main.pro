:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/

	marchandises(Stocks),
	afficherBourse(Stocks),
	decrement(Stocks, sucre, NewStocks),
	afficherBourse(NewStocks).
