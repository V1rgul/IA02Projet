:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').


afficherListe([]).
afficherListe([T|Q]) :-
	write(T),
	write('\n'),
	afficherListe(Q).

afficherBourse(Stocks) :-
	write('Voici les cours de la bourses:\n'),
	afficherListe(Stocks).

main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/

	marchandises(Stocks),
	afficherBourse(Stocks),
	decrement(Stocks, sucre, NewStocks),
	afficherBourse(NewStocks).
