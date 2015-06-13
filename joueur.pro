
%Reserve, correspond a un joueur : [[sucre,3],[ble,1]]


createPlayerHuman([joueurHumain, [[ble,0],[riz,0],[cacao,0],[cafe,0],[sucre,0],[mais,0]] ]).
createPlayerIA(   [joueurIA,     [[ble,0],[riz,0],[cacao,0],[cafe,0],[sucre,0],[mais,0]] ]).

createPlayersIA(0, []) :- !.
createPlayersIA(Nombre, Players) :-
	NewNombre is Nombre-1,
	createPlayersIA(NewNombre, NewPlayers),
	createPlayerIA(NewP),
	append(NewPlayers, [NewP], Players).

createPlayersHuman(0, []) :- !.
createPlayersHuman(Nombre, Players) :-
	NewNombre is Nombre-1,
	createPlayersHuman(NewNombre, NewPlayers),
	createPlayerHuman(NewP),
	append(NewPlayers, [NewP], Players).

createPlayers(NHumans, NIAs, Players) :-
	createPlayersHuman(NHumans, Humans),
	createPlayersIA(   NIAs,    IAs),
	append(Humans, IAs, Players),
	print('Created '), print(NHumans), print(' Humans and '), print(NIAs), print(' IAs.'), nl.

%getPlayer(+Players,+Index,-Player)
getPlayer(Players, Index, Player) :-
	nth0(Index, Players, Player).

%setPlayer(+Players,-NewPlayers,+Index,+Player)
setPlayer(Players, NewPlayers, Index, Player) :-
	%print('Debug setPlayer '), print(Index), print(Players), nl,
	replace(Players, Index, Player, NewPlayers).
	%print('Debug setPlayer A'), print(NewPlayers), nl.

getPlayerReserve(Player, Reserve) :-
	nth0(1, Player, Reserve).

setPlayerReserve(Player, Reserve, NewPlayer) :-
	replace(Player, 1, Reserve, NewPlayer).

%getPlayerPoints(+Bourse, +Reserve, -Points) :-
getPlayerPoints(Bourse, Reserve, Points) :-
	getValueOf(Bourse, ble, ValueBleBourse),
	getValueOf(Reserve, ble, ValueBleReserve),
	BlePoints is ValueBleBourse*ValueBleReserve,
	getValueOf(Bourse, riz, ValueRizBourse),
	getValueOf(Reserve, riz, ValueRizReserve),
	RizPoints is ValueRizBourse*ValueRizReserve,
	getValueOf(Bourse, cacao, ValueCacaoBourse),
	getValueOf(Reserve, cacao, ValueCacaoReserve),
	CacaoPoints is ValueCacaoBourse*ValueCacaoReserve,
	getValueOf(Bourse, cafe, ValueCafeBourse),
	getValueOf(Reserve, cafe, ValueCafeReserve),
	CafePoints is ValueCafeBourse*ValueCafeReserve,
	getValueOf(Bourse, sucre, ValueSucreBourse),
	getValueOf(Reserve, sucre, ValueSucreReserve),
	SucrePoints is ValueSucreBourse*ValueSucreReserve,
	getValueOf(Bourse, mais, ValueMaisBourse),
	getValueOf(Reserve, mais, ValueMaisReserve),
	MaisPoints is ValueMaisBourse*ValueMaisReserve,
	Points is BlePoints+RizPoints+CacaoPoints+CafePoints+SucrePoints+MaisPoints.



getPlayerType(Player, Type) :-
	nth0(0, Player, Type).

playerIsHuman(Player) :-
	getPlayerType(Player, Type),
	Type == joueurHumain.

playerIsIA(Player) :-
	getPlayerType(Player, Type),
	Type == joueurIA.

%nextPlayer(+Players,+Index,-NewIndex)
nextPlayer( Players, Index, NewIndex) :-
	length(Players, Length),
	NewIndex is (Index+1) mod Length.
 
otherElem(0, 1) :- !.
otherElem(1, 0) :- !.
otherElem(V, 0) :-
	print('otherElem invalid value : '), print(V), nl,
	!.

%jouer(+Reserve, -NewReserve, +Bourse, -NewBourse, +ElemGarde, +ElemVendre)
jouer(Player, NewPlayer, Bourse, NewBourse, Elems, Prendre) :-
	nth0(Prendre, Elems, ElemGarde),
	otherElem(Prendre, Vendre),
	nth0(Vendre, Elems, ElemVendre),
	getPlayerReserve(Player, Reserve),
	increment(Reserve, ElemGarde, NewReserve),
	setPlayerReserve(Player, NewReserve, NewPlayer),
	%print('Debug NewPlayer '), print(NewPlayer), nl, 
	decrement(Bourse, ElemVendre, NewBourse).
