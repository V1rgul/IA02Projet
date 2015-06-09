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

%getState(-Piles, -Bourse, -Trader) : get the current state of the game
getState(Piles, Bourse, Trader) :-
	currentPiles(Piles),
	currentBourse(Bourse),
	currentPos(Trader).

%setState(+Piles, +Bourse, +Trader) : set the new state of the game
setState(Piles, Bourse, Trader) :-
	asserta(currentBourse(Bourse)),
	asserta(currentPiles(Piles)),
	asserta(currentPos(Trader)).

init :-
	plateauInit(Piles, Bourse, Trader),
	setState(Piles, Bourse, Trader).

displayState :-
	getState(Piles, Bourse, Trader),
	plateauDisplay(Piles, Bourse, Trader),
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


done :-
	getState(Piles, _, _),
	!,
	%print('Debug Piles: '), print(Piles), nl,
	plateauCheckEnd(Piles),
	nl,
	print('Partie terminee !'), nl.


testAvancer(Dist) :-
	getState(Piles, Bourse, Trader),

	plateauAvancer(Piles, NewPiles, Trader, NewTrader, Dist, Elem1, Elem2),
	print('Avance de '), print(Dist), print(', pions pris : '), print(Elem1), print(' et '), print(Elem2), nl, 

	setState(NewPiles, Bourse, NewTrader).