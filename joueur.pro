
%Reserve, correspond a un joueur : [[sucre,3],[ble,1]]

%jouer(+Reserve, -NewReserve, +Bourse, -NewBourse, +ElemGarde, +ElemVendre)
jouer(Reserve, NewReserve, Bourse, NewBourse, ElemGarde, ElemVendre) :-
	increment(Reserve, ElemGarde, NewReserve),
	decrement(Bourse, ElemVendre, NewBourse).
