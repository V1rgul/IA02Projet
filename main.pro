:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').
:- include('iaSmart.pro').

spy.


main(JoueursHumains, JoueursIA) :-
	JoueursHumains >= 0,
	JoueursHumains =< 4,
	JoueursIA >= 0,
	JoueursIA =< 4,
	JoueursSomme is JoueursHumains + JoueursIA,
	JoueursSomme =< 4,
	!,
	init(JoueursHumains, JoueursIA),
	print('Welcome !'), nl,
	instructions,
	go.

main(_             , _        ) :-
	print('Le nombre de joueurs humains et IA doit etre entre 0 et 4, et la somme des 2 inferieure a 4'),
	!.

init(JoueursHumains, JoueursIA) :-
	plateauInit(Piles, Bourse, Trader),
	spy,
	createPlayers(JoueursHumains, JoueursIA, Players),
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
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant),
	plateauDisplay(Piles, Bourse, Trader),
	getPlayer(Joueurs, JoueurCourant, Joueur),
	getPlayerType(Joueur, Type),
	print('Tour de '), print(Type), print(' numero '), print(JoueurCourant), nl,
	!. %important, cant let choice point here

instructions :-
	nl,
	print('Enter commands at the prompt as Prolog terms, ending in period:'), nl,
	print('  help. \t- this information.'), nl,
	print('  quit. \t- exit the game.'), nl,
	print('  stock.\t- show your current stocks'), nl,
	nl.

go :- done.
go :- %next player is an IA
	nextIsIAJouer, !,
	displayState,
	!, go.
go :- %next player is a Human
	displayState,
	print('>> '),
	read(X),
	nextIsIAJouer,
	X \= quit,
	do(X),
	!, go.
go :- print(' Exit ! '), nl.


do(help) 		:- !, instructions.
do(quit) 		:- !.
do(avance1_AV)	:- !, avancer(1, 0).
do(avance1_VA)	:- !, avancer(1, 1).
do(avance2_AV)	:- !, avancer(2, 0).
do(avance2_VA)	:- !, avancer(2, 1).
do(stock)		:- !, stock.
do(X) :- print('Unknown command : "'), print(X), print('"'), nl, instructions.


done :-
	getState(Piles, _, _, _, _),
	!,
	%print('Debug Piles: '), print(Piles), nl,
	plateauCheckEnd(Piles),
	nl,
	print('Partie terminee !'), nl.


nextIsIAJouer :-
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant),
	getPlayer(Joueurs, JoueurCourant, Joueur),
	getPlayerType(Joueur, Type),
	Type == joueurIA,

	print('Is an IA'), nl,
	getPlayerReserve(Joueur, Reserve),
	otherElem(JoueurCourant, JoueurCourantOther), %I know, uses another functions for smthg else
	getPlayer(Joueurs, JoueurCourantOther, JoueurOther),
	getPlayerReserve(JoueurOther, ReserveOther),

	iaJouer(Bourse, Piles, Trader, Reserve, ReserveOther, Dist, Prendre),
	avancer(Dist, Prendre),
	print('Ia numero '), print(JoueurCourant), print(' a fini de jouer'), nl,
	!.

nextIsIAJouer :- 
	print('Not an IA'), nl,
	fail,
	!.



avancer(Dist, Prendre) :-
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant),

	plateauAvancer(Piles, NewPiles, Trader, NewTrader, Dist, Elems),
	print('Avance de '), print(Dist), print(', pions pris : '), print(Elems), nl,

	getPlayer(Joueurs, JoueurCourant, Player),
	%print('Debug Selected Player : '), print(Player), nl,
	jouer(Player, NewPlayer, Bourse, NewBourse, Elems, Prendre), 
	setPlayer(Joueurs, NewJoueurs, JoueurCourant, NewPlayer),

	nextPlayer(Joueurs, JoueurCourant, NewJoueurCourant),

	setState(NewPiles, NewBourse, NewTrader, NewJoueurs, NewJoueurCourant),
	!.


stock :-
	getState(_, _, _, Joueurs, JoueurCourant),
	getPlayer(Joueurs, JoueurCourant, Player),
	getPlayerReserve(Player, Reserve),
	print('Stock for player numero '), print(JoueurCourant), print(' : '), print(Reserve), nl,
	!.


/*TEST*/

test([[sucre,riz,ble],[cacao,cafe],[mais]]).


test_bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
test_a([[ble,1],[riz,2],[cacao,1],[cafe,2],[sucre,1],[mais,1]]).
test_b([[ble,1],[riz,1],[cacao,1],[cafe,1],[sucre,1],[mais,1]]).
af([1,2,3]).


test_stuff :-
/*	plateauDisplay(Piles, Bourse, Pos), nl,s

	emptyList(J1),

	jouer(J1, _ , Bourse, NewBourse, Elem1, Elem2),
	print('Garde de '), print(Elem1), print(', Vente de '), print(Elem2), nl,

	plateauDisplay(Piles14, NewBourse, Pos14).*/
	test_bourse(Bourse),
	test_a(Reserve),
	test_b(OtherReserve),
	genererPiles(Pile),
	%print(Stocks), nl,
	iaJouer(Bourse, Pile, 0, Reserve, OtherReserve, A, B),
	print(A), nl,
	print(B), nl.
