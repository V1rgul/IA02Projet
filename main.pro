marchandises([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

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