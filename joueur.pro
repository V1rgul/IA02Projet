
%Reserve, correspond a un joueur : [[sucre,3],[ble,1]]


%createPlayer(-Player)
createPlayer(Player) :-
	emptyList(Player).

%createPlayers(+Nombre, -Players)
%	Exemple:
%	+Nombre:	2
%	-Players:	[[],[]]
createPlayers(0, []) :- !.
createPlayers(Nombre, Players) :-
	NewNombre is Nombre-1,
	createPlayers(NewNombre, NewPlayers),
	createPlayer(NewP),
	append(NewPlayers, [NewP], Players).

%getPlayer(+Players,+Index,-Player)
/*getPlayer(Index,Player) :-
	nth0(Index, )*/


%jouer(+Reserve, -NewReserve, +Bourse, -NewBourse, +ElemGarde, +ElemVendre)
jouer(Reserve, NewReserve, Bourse, NewBourse, ElemGarde, ElemVendre) :-
	increment(Reserve, ElemGarde, NewReserve),
	decrement(Bourse, ElemVendre, NewBourse).
