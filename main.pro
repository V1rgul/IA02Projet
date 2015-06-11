:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').

spy.


main(JoueursHumains) :-
	JoueursHumains >= 0,
	JoueursHumains =< 2,
	!,
	init(JoueursHumains),
	print('Welcome !'), nl,
	instructions,
	go.

main(_             ) :-
	print('Le nombre de joueurs humains doit etre entre 0 et 2'),
	!.

init(JoueursHumains) :-
	plateauInit(Piles, Bourse, Trader),
	spy,
	createPlayers(JoueursHumains, Players),
	setState(Piles, Bourse, Trader, Players, 0).

%getState(-Piles, -Bourse, -Trader, -Joueurs, -JoueurCourant) : get the current state of the game
getState(Piles, Bourse, Trader, Joueurs, JoueurCourant) :-
	currentPiles(Piles),
	currentBourse(Bourse),
	currentPos(Trader),
	currentJoueurs(Joueurs),
	currentJoueur(JoueurCourant).

%setState(+Piles, +Bourse, +Trader, +Joueurs, +JoueurCourant) : set the new state of the game
setState(Piles, Bourse, Trader, Joueurs, JoueurCourant) :-
	asserta(currentBourse(Bourse)),
	asserta(currentPiles(Piles)),
	asserta(currentPos(Trader)),
	asserta(currentJoueurs(Joueurs)),
	asserta(currentJoueur(JoueurCourant)).

displayState :-
	getState(Piles, Bourse, Trader, _, JoueurCourant),
	plateauDisplay(Piles, Bourse, Trader),
	print('Tour de Joueur numero: '), print(JoueurCourant), nl,
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
do(avance1_AV) :- !, avancer(1, 0).
do(avance1_VA) :- !, avancer(1, 1).
do(avance2_AV) :- !, avancer(2, 0).
do(avance2_VA) :- !, avancer(2, 1).
do(X) :- print('Unknown command : "'), print(X), print('"'), nl, instructions.


done :-
	getState(Piles, _, _, _, _),
	!,
	%print('Debug Piles: '), print(Piles), nl,
	plateauCheckEnd(Piles),
	nl,
	print('Partie terminee !'), nl.




avancer(Dist, Prendre) :-
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant),

	plateauAvancer(Piles, NewPiles, Trader, NewTrader, Dist, Elems),
	print('Avance de '), print(Dist), print(', pions pris : '), print(Elems), nl,

	getPlayer(Joueurs, JoueurCourant, Player),
	jouer(Player, NewPlayer, Bourse, NewBourse, Elems, Prendre), 
	setPlayer(Joueurs, NewJoueurs, JoueurCourant, NewPlayer),

	setState(NewPiles, NewBourse, NewTrader, NewJoueurs, JoueurCourant),
	!.

avancerIA :-
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant).



/*TEST*/

test([[sucre,riz,ble],[cacao,cafe],[mais]]).


test_bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
af([1,2,3]).


test_stuff :-
/*	plateauDisplay(Piles, Bourse, Pos), nl,s

	emptyList(J1),

	jouer(J1, _ , Bourse, NewBourse, Elem1, Elem2),
	print('Garde de '), print(Elem1), print(', Vente de '), print(Elem2), nl,

	plateauDisplay(Piles14, NewBourse, Pos14).*/
	test_bourse(Stocks),
	print(Stocks),
	increment(Stocks, rien, NewStocks),
	print(NewStocks).
