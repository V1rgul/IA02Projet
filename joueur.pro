
%Reserve, correspond a un joueur : [[sucre,3],[ble,1]]


createPlayerHuman([joueurHumain, [[ble,0],[riz,0],[cacao,0],[cafe,0],[sucre,0],[mais,0]] ]).
createPlayerIA(   [joueurIA,     [[ble,0],[riz,0],[cacao,0],[cafe,0],[sucre,0],[mais,0]] ]).

createPlayers(0, []) :- !.
createPlayers(Nombre, Players) :-
	NewNombre is Nombre-1,
	createPlayers(NewNombre, NewPlayers),
	createPlayerHuman(NewP),
	append(NewPlayers, [NewP], Players).

%getPlayer(+Players,+Index,-Player)
getPlayer(Players, Index, Player) :-
	nth0(Index, Players, Player).

%setPlayer(+Players,-NewPlayers,+Index,+Player)
setPlayer(Players, NewPlayers, Index, Player) :-
	replace(Players, Index, Player, NewPlayers).

getPlayerReserve(Player, Reserve) :-
	nth0(1, Player, Reserve).

setPlayerReserve(Player, Reserve, NewPlayer) :-
	replace(Player, 1, Reserve, NewPlayer).


getPlayerType(Player, Type) :-
	nth0(0, Player, Type).

playerIsHuman(Player) :-
	getPlayerType(Player, Type),
	Type == joueurHumain.

playerIsIA(Player) :-
	getPlayerType(Player, Type),
	Type == joueurIA.

 
otherElem(0, 1) :- !.
otherElem(1, 0) :- !.

%jouer(+Reserve, -NewReserve, +Bourse, -NewBourse, +ElemGarde, +ElemVendre)
jouer(Player, NewPlayer, Bourse, NewBourse, Elems, Prendre) :-
	nth0(Prendre, Elems, ElemGarde),
	otherElem(Prendre, Vendre),
	nth0(Vendre, Elems, ElemVendre),
	getPlayerReserve(Player, Reserve),
	increment(Reserve, ElemGarde, NewReserve),
	setPlayerReserve(Player, NewReserve, NewPlayer),
	print('Debug NewPlayer '), print(NewPlayer), nl, 
	decrement(Bourse, ElemVendre, NewBourse).
