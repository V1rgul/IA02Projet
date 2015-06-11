emptyList([]).


appendNonEmptyA([[]], B,  C) :-
	C = B.
appendNonEmptyA(A, B, C) :-
	append(A, B, C).

appendNonEmptyA([], B,  C) :-
	C = B.
appendNonEmptyA(A, B, C) :-
	append(A, B, C).


%decrement(+List,+SearchedName,-NewList)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	+SearchedName:		sucre
%	-NewList:	[[sucre,2],[ble,1]]
%	Exemple:
%	+List:		[[sucre,1],[ble,1]]
%	+SearchedName:		sucre
%	-NewList:	[[ble,1]]
decrement([]   , _           , []     ) :- !.
decrement([T|Q], SearchedName, NewList) :-
	[Name, Value] = T,
	decrementValue(Name, Value, SearchedName, DecrementedElem),
	decrement(Q, SearchedName, NewListRec),
	append(DecrementedElem, NewListRec, NewList).
decrementValue(SearchedName, Value, SearchedName, Elem) :-
	ValueTemp is Value-1,
	Elem = [[SearchedName, ValueTemp]].
decrementValue(Name        , Value, _           , Elem) :-
	Elem = [[Name, Value]].


%increment(+List,+Elem,-NewList)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	+Elem:		sucre
%	-NewList:	[[sucre,4],[ble,1]]
%	Exemple:
%	+List:		[[ble,1]]
%	+Elem:		sucre
%	-NewList:	[[sucre,1],[ble,1]]
increment([]   , _           , []     ) :- !.
increment([T|Q], SearchedName, NewList) :-
	[Name, Value] = T,
	incrementValue(Name, Value, SearchedName, IncrementedElem),
	increment(Q, SearchedName, NewListRec),
	append(IncrementedElem, NewListRec, NewList).
incrementValue(SearchedName, Value, SearchedName, Elem) :-
	ValueTemp is Value+1,
	Elem = [[SearchedName, ValueTemp]].
incrementValue(Name        , Value, _           , Elem) :-
	Elem = [[Name, Value]].


%prendrePion(+Piles,+Pos,-NewPiles,-Elem)
%	Exemple:
%	+Pile:		[[sucre,riz,ble],[cacao,cafe],[mais]]
%	-NewPile	[[sucre,riz,ble],[cafe],[mais]]
%	+Pos:		1
%	-Elem:		cacao
%	Exemple:
%	+Pile:		[[sucre,riz,ble],[cacao,cafe],[mais]]
%	-NewPile	[[sucre,riz,ble],[cacao,cafe]]
%	+Pos:		2
%	-Elem:		mais
prendrePion([], _, [], _) :- !.
prendrePion([T|Q], 0, NewPiles, ElemToRemove) :-
	[Elem|Others] = T,
	ElemToRemove = Elem,
	prendrePion(Q, -1, TempNewPiles, ElemToRemove),
	appendNonEmptyA([Others], TempNewPiles, NewPiles).
prendrePion([T|Q], Pos, NewPiles, ElemToRemove) :-
	TempPos is Pos-1,
	prendrePion(Q, TempPos, TempNewPiles, ElemToRemove),
	append([T], TempNewPiles, NewPiles).

%replace(+Liste +Pos, +RemplaceBy, -NewListe)
%	Exemple:
%	+List:			[sucre, ble, rien]
%	+Pos: 			0
%	+RemplaceBy:	stuff
%	-NewListe: 		[stuff, ble, rien]
%	----------------------------------------
%	Exemple:
%	+List:			[[sucre,3],[ble,1]]
%	+Pos: 			1
%	+RemplaceBy:	[ble, 0]
%	-NewListe: 		[[sucre,3],[ble,0]]
replace([T|Q], Pos, RemplaceBy, NewListe) :-
	private_replace([T|Q], Pos, RemplaceBy, 0, NewListe).
private_replace([], _	, _	, _, []) :- !.
private_replace([_|Q], SamePos, RemplaceBy, SamePos, NewListe) :-
	TempSamePos is SamePos+1,
	private_replace(Q, SamePos, RemplaceBy, TempSamePos, TempListe),
	append([RemplaceBy], TempListe, NewListe).
private_replace([T|Q], Pos, RemplaceBy, Index, NewListe) :-
	TempIndex is Index+1,
	private_replace(Q, Pos, RemplaceBy, TempIndex, TempListe),
	append([T], TempListe, NewListe).

%randomElem(+Liste, -Element)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	-Elem:		ble
randomElem(Liste, Element) :-
	privateRandomElem(Liste, Element, 0, _).
privateRandomElem(Liste, Element, 0, _) :-
	length(Liste, Size),
    random(0, Size, Index),
    nth0(Index, Liste, ElementValue),
    nth0(0, ElementValue, TempElement),
    nth0(1, ElementValue, Value),
    !,
	privateRandomElem(Liste, Element, Value,TempElement).
privateRandomElem(_, Element, _, TempElement) :- 
	Element = TempElement,
	!.
	


	
%inverseKV(+List,-NewList)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	-NewList:	[[3,sucre],[1,ble]]
inverseKV([],[]).
inverseKV([H|T],[NH|NT]) :-
	nth0(0, H, K),
	nth0(1, H, V),
	NH = [V, K],
	inverseKV(T, NT).



%printIfElse(+A, +B, +TextEquals, +TextNonEquals)
%prints TextEquals if A == B, TextNonEquals else
printIfElse(A, A, TextEquals, _            ) :-
	print(TextEquals), !.
printIfElse(_, _, _         , TextNonEquals) :-
	print(TextNonEquals).


printTable(Table, Title, TitleSpaces) :-
	length(Table, Length),
	printTable(Table, Title, TitleSpaces, 0, Length).
printTable(_    , _    , _          , Length, Length) :- !.
printTable(Table, Title, TitleSpaces, Pos   , Length) :-
	printIfElse(Pos, 0, Title, TitleSpaces),
	nth0(Pos, Table, Line),
	length(Line, LineLength),
	printTableLine(Line, 0, LineLength), nl,
	Pos2 is Pos+1,
	printTable(Table, Title, TitleSpaces, Pos2, Length).

printTableLine(_   , Length, Length) :- !.
printTableLine(Line, Pos   , Length) :-
	printIfElse(Pos, 0, '', ' | '),
	nth0(Pos, Line, Elem),
	print(Elem),
	Pos2 is Pos+1,
	printTableLine(Line, Pos2, Length).


	

