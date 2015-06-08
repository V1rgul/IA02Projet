bourse(				[[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
marchandisesDepart(	[[ble,6],[riz,6],[cacao,6],[cafe,2],[sucre,2],[mais,1]]).



takeElement(Marchandises, Elem, NewMarchandises) :-  %Needs to be removed
	randomElem(Marchandises, Elem),
	decrement(Marchandises, Elem, NewMarchandises).

genererPile(Marchandises, NewPile, NewMarchandises) :-
	emptyList(Pile),
	takeElement(Marchandises , E1, Marchandises2),
	takeElement(Marchandises2, E2, Marchandises3),
	takeElement(Marchandises3, E3, Marchandises4),
	takeElement(Marchandises4, E4, NewMarchandises),
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






%plateauAvancer(+Piles, -NewPiles, +Pos, -NewPos, +Dist, -Elem1, -Elem2)
plateauAvancer(Piles, NewPiles, Pos, NewPos, Dist, Elem1, Elem2) :-
	Dist > 0,
	Dist =< 3, %end of checks
	length(Piles, L1),
	NewPos  is (Pos + Dist) mod L1,
	PosPrendre1 is (NewPos - 1) mod L1,  %mod always return positive numbers
	prendrePion( Piles , Piles2  , PosPrendre1, Elem1 ),
	length(Piles2, L2), %A pile could have been removed
	PosPrendre2 is (NewPos + 1) mod L2,
	prendrePion( Piles2, NewPiles, PosPrendre2, Elem2 ).



%plateauCheckEnd(+Piles)
plateauCheckEnd(Piles) :-
	length(Piles, Length),
	Length =< 2.


printPiles(Piles, Trader) :-
	length(Piles, Length),
	printPiles(Piles, Trader, 0, Length).

printPiles(_    , _     , Length, Length) :- !.
printPiles(Piles, Trader, Pos   , Length) :-
	printIfElse(0     , Pos  , 'Piles:\t'  , '      \t'  ),
	printIfElse(Trader, Pos, 'Trader | ', '       | '),
	nth0(Pos, Piles, Pile),
	printPile(Pile), nl,
	NewPos is Pos+1,
	printPiles(Piles, Trader, NewPos, Length).

printPile(Pile) :-
	nth0(0, Pile, Top),
	print(Top), print('\t'),
	length(Pile, Length),
	printPileStack(Length-1).
printPileStack(0) :- !.
printPileStack(N) :-
	N2 is N - 1,
	print('------ '),
	printPileStack(N2).



%plateauDisplay(+Bourse, +Piles, +Pos)
plateauDisplay(Piles,Bourse,Pos) :-
	
	inverseKV(Bourse, InvertedBourse),
	msort(InvertedBourse, BourseTriee),
	reverse(BourseTriee, BourseTrieeDescendant),
	printTable(BourseTrieeDescendant, 'Bourse:\t', '       \t'),

	printPiles(Piles, Pos).