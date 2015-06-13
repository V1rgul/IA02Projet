:- include('utils.pro').
:- include('plateau.pro').
:- include('joueur.pro').
:- include('iaSmart.pro').

spy.


main(JoueursHumains) :-
	JoueursIA is 2-JoueursHumains,
	main(JoueursHumains, JoueursIA).


main(JoueursHumains, JoueursIA) :-
	JoueursHumains >= 0,
	JoueursHumains =< 2,
	JoueursIA >= 0,
	JoueursIA =< 2,
	JoueursSomme is JoueursHumains + JoueursIA,
	JoueursSomme =< 2,
	!,
	init(JoueursHumains, JoueursIA),
	print('Welcome !'), nl,
	instructions,
	go.

main(_             , _        ) :-
	print('Le nombre de joueurs humains et IA doit etre entre 0 et 2, et la somme des 2 inferieure a 2'),
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
	print('  score.\t- show your current score'), nl,
	print('  avance1_AV. \t- Do one step,    buy the first item, sell the second one.'), nl,
	print('  avance1_VA. \t- Do one step,    sell the first item, buy the second one.'), nl,
	print('  avance2_AV. \t- Do two steps,   buy the first item, sell the second one.'), nl,
	print('  avance2_VA. \t- Do two steps,   sell the first item, buy the second one.'), nl,
	print('  avance3_AV. \t- Do three steps, buy the first item, sell the second one.'), nl,
	print('  avance3_VA. \t- Do three steps, sell the first item, buy the second one.'), nl,
	nl.

go :- done.
go :- %next player is a Human
	displayState,
	play,
	!, go.
go :- print(' Exit ! '), nl.

play :- %IA
	nextIsIAJouer,
	!.
play :- %Human
	print('>> '),
	read(X),
	X \= quit,
	do(X),
	!.


do(help) 		:- !, instructions.
do(quit) 		:- !.
do(avance1_AV)	:- !, avancer(1, 0).
do(avance1_VA)	:- !, avancer(1, 1).
do(avance2_AV)	:- !, avancer(2, 0).
do(avance2_VA)	:- !, avancer(2, 1).
do(avance3_AV)	:- !, avancer(3, 0).
do(avance3_VA)	:- !, avancer(3, 1).
do(stock)		:- !, stock.
do(score)		:- !, score.
do(X) :- print('Unknown command : "'), print(X), print('"'), nl, instructions.


done :-
	getState(Piles, _, _, _, _),
	!,
	%print('Debug Piles: '), print(Piles), nl,
	plateauCheckEnd(Piles),
	nl,
	print('Game over !'), nl,
	displayScores,
	!.



displayScores :-
	getState(_, Bourse, _, Joueurs, _),
	printScores(Bourse, Joueurs).

nextIsIAJouer :-
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant),
	getPlayer(Joueurs, JoueurCourant, Joueur),
	getPlayerType(Joueur, Type),
	%print('Player Type: '), print(Type), nl,
	!, %apparently important cut
	Type = joueurIA,
	!,
	%print('Is an IA'), nl,
	getPlayerReserve(Joueur, Reserve),
	otherElem(JoueurCourant, JoueurCourantOther), %I know, uses another functions for smthg else
	getPlayer(Joueurs, JoueurCourantOther, JoueurOther),
	getPlayerReserve(JoueurOther, ReserveOther),

	iaJouer(Bourse, Piles, Trader, Reserve, ReserveOther, Dist, Prendre),
	avancer(Dist, Prendre),
	print('Ia numero '), print(JoueurCourant), print(' a fini de jouer'), nl,
	!.

nextIsIAJouer :- 
	%print('Not an IA'), nl,
	fail,
	!.



avancer(Dist, Prendre) :-
	getState(Piles, Bourse, Trader, Joueurs, JoueurCourant),

	plateauAvancer(Piles, NewPiles, Trader, NewTrader, Dist, Elems),
	print('Avance de '), print(Dist), print(', '), %nl, %print(', pions pris : '), print(Elems), nl,

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

score :-
	getState(_, Bourse, _, Joueurs, JoueurCourant),
	getPlayer(Joueurs, JoueurCourant, Joueur),
	getPlayerReserve(Joueur, Reserve),
	getPlayerPoints(Bourse, Reserve, Points),
	print('Score for player numero '), print(JoueurCourant), print(' : '), print(Points), nl,
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
