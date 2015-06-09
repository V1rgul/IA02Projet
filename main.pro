:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').



test([[sucre,riz,ble],[cacao,cafe],[mais]]).

spy.

main :-

	init,
	print('Welcome !'), nl,
	instructions,
	go.

/*	plateauDisplay(Piles, Bourse, Pos), nl,

	emptyList(J1),

	jouer(J1, _ , Bourse, NewBourse, Elem1, Elem2),
	print('Garde de '), print(Elem1), print(', Vente de '), print(Elem2), nl,

	plateauDisplay(Piles14, NewBourse, Pos14).

	/*test(Stocks),
	print(Stocks),
	prendrePion(Stocks, 2, NewStocks, Elem),
	print(Elem),
	print(NewStocks).*/

%getState(-Piles, -Bourse, -Pos) : get the current state of the game
getState(Piles, Bourse, Pos) :-
	currentPiles(Piles),
	currentBourse(Bourse),
	currentPos(Pos).

%setState(+Piles, +Bourse, +Pos) : set the new state of the game
setState(Piles, Bourse, Pos) :-
	asserta(currentBourse(Bourse)),
	asserta(currentPiles(Piles)),
	asserta(currentPos(Pos)).

init :-
	plateauInit(Piles, Bourse, Pos),
	setState(Piles, Bourse, Pos).

displayState :-
	getState(Piles, Bourse, Pos),
	plateauDisplay(Piles, Bourse, Pos),
	!. %important, cant let choice point here

instructions :-
	nl,
	print('Enter commands at the prompt as Prolog terms, ending in period:'), nl,
	print('  help. - this information.'), nl,
	print('  quit. - exit the game.'), nl,
	print('  testAvancer(Dist). '), nl,
	nl.

go :- done.
go :-
	displayState,
	print('>> '),
	read(X),
	X \= quit,
	do(X),
	!, go.
go :- print(' Exit ! '), nl.


do(help) 			:- !, instructions.
do(quit) 			:- !.
do(testAvancer(X)) 	:- !, testAvancer(X).
do(X) :- print('Unknown command : "'), print(X), print('"'), nl, instructions.


done :- fail, !. %%no end check for now


testAvancer(Dist) :-
	getState(Piles, Bourse, Pos),

	plateauAvancer(Piles, NewPiles, Pos, NewPos, Dist, Elem1, Elem2),
	print('Avance de 2, devrait prendre : '), print(Elem1), print(' et '), print(Elem2), nl, 

	setState(NewPiles, Bourse, NewPos).