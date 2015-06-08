
%Reserve, correspond a un joueur : [[sucre,3],[ble,1]]

%jouer(+Reserve, -NewReserve, +Bourse, -NewBourse, +ElemGarder, +ElemVendre)
jouer(Reserve, NewReserve, Bourse, NewBourse, ElemGarder, ElemVendre) :-
	increment(Reserve, ElemGarder, NewReserve),
	decrement(Bourse, ElemVendre, NewBourse).
