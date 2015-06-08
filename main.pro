:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



main :-
	/*do(take(X)) :- !, take(X).
	do(X) :- print("unknown command:"), print(X), nl.

	take(X) :-
		print('take:'), print(X), nl.*/

	plateauInit(Piles, Bourse, Pos),
	plateauDisplay(Piles, Bourse, Pos), nl,



	decrement(Bourse, sucre, NewBourse),
	plateauDisplay(Piles, NewBourse, Pos).
