bourse(				[[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
marchandisesDepart(	[[ble,6],[riz,6],[cacao,6],[cafe,2],[sucre,2],[mais,1]]).




genererPile(Marchandises, NewPile, NewMarchandises) :-
	emptyList(Pile),
	randomElem(Marchandises , E1),
	decrement(Marchandises , E1, Marchandises2), %needs to be in this order to avoid selected unavailable products
	randomElem(Marchandises2, E2),
	decrement(Marchandises , E2, Marchandises3),
	randomElem(Marchandises3, E3),
	decrement(Marchandises , E3, Marchandises4),
	randomElem(Marchandises4, E4),
	decrement(Marchandises , E4, NewMarchandises),
	append(Pile , [E1], Pile2),
	append(Pile2, [E2], Pile3),
	append(Pile3, [E3], Pile4),
	append(Pile4, [E4], NewPile).

genererPiles(NewPiles) :-
	marchandisesDepart(M),
	genererPile(M , P1, M1),
	genererPile(M1, P2, M2),
	genererPile(M2, P3, M3),
	genererPile(M3, P4, M4),
	genererPile(M4, P5, M5),
	genererPile(M5, P6, M6),
	genererPile(M6, P7, M7),
	genererPile(M7, P8, M8),
	genererPile(M8, P9, _),
	emptyList(Piles),
	append(Piles , [P1], Piles1),
	append(Piles1, [P2], Piles2),
	append(Piles2, [P3], Piles3),
	append(Piles3, [P4], Piles4),
	append(Piles4, [P5], Piles5),
	append(Piles5, [P6], Piles6),
	append(Piles6, [P7], Piles7),
	append(Piles7, [P8], Piles8),
	append(Piles8, [P9], NewPiles),
	!.

%plateauInit(-Piles, -Bourse, -Pos)
plateauInit(Piles, Bourse, Pos) :-
	genererPiles(Piles),
	bourse(Bourse),
	Pos is 0.


%decrementIfRemoved(+Length1,+Length2,+PosPrendre,+Pos,-NewPos)
decrementIfRemoved(Length , Length , _         , Pos, Pos   ) :-
	!. %Nothing was removed
decrementIfRemoved(_      , _      , PosPrendre, Pos, Pos   ) :-
	PosPrendre >= Pos,
	!. %PosPrendre was after trader pos
decrementIfRemoved(_     , _       , _         , Pos, NewPos) :-
	print('Debug: A pile was removed before trader pos !'), nl,
	NewPos is Pos-1.


%plateauAvancer(+Piles, -NewPiles, +Pos, -NewPos, +Dist, -Elem1, -Elem2)
plateauAvancer(Piles, NewPiles, Pos, NewPos, Dist, Elem1, Elem2) :-
	Dist > 0,
	Dist =< 3, %end of checks
	length(Piles, L1),
	Pos2  is (Pos + Dist) mod L1,
	PosPrendre1 is (Pos2 - 1) mod L1,  %mod always return positive numbers
	prendrePion( Piles, PosPrendre1, Piles2, Elem1 ),

	length(Piles2, L2), % A pile could have been removed
	decrementIfRemoved(L1, L2, PosPrendre1, Pos2, Pos3),

	PosPrendre2 is (Pos3 + 1) mod L2,
	prendrePion( Piles2, PosPrendre2, NewPiles, Elem2 ),

	length(NewPiles, L3), % A pile could have been removed
	decrementIfRemoved(L2, L3, PosPrendre2, Pos3, NewPos).



%plateauCheckEnd(+Piles)
plateauCheckEnd(Piles) :-
	length(Piles, Length),
	!,
	Length =< 2.


printPiles(Piles, Trader) :-
	length(Piles, Length),
	printPiles(Piles, Trader, 0, Length).

printPiles(_    , _     , Length, Length) :- !.
printPiles(Piles, Trader, Pos   , Length) :-
	printIfElse(0     , Pos, 'Piles:\t'  , '      \t'  ),
	printIfElse(Trader, Pos, 'Trader | ' , '       | ' ),
	nth0(Pos, Piles, Pile),
	printPile(Pile), nl,
	NewPos is Pos+1,
	printPiles(Piles, Trader, NewPos, Length).

printPile(Pile) :-
	nth0(0, Pile, Top),
	print(Top), print('\t'),
	length(Pile, Length),
	LengthMinus is Length-1,
	printPileStack(LengthMinus).
printPileStack(0) :- !.
printPileStack(N) :-
	N2 is N - 1,
	print('------ '),
	printPileStack(N2).



%plateauDisplay(+Bourse, +Piles, +Pos)
plateauDisplay(Piles,Bourse,Pos) :-
	
	print('Etat du jeu :'), nl, 
	inverseKV(Bourse, InvertedBourse),
	msort(InvertedBourse, BourseTriee),
	reverse(BourseTriee, BourseTrieeDescendant),
	printTable(BourseTrieeDescendant, 'Bourse:\t', '       \t'),

	printPiles(Piles, Pos),
	print('Debug Piles: '), print(Piles), nl.