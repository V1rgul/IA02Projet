

emptyList([]).

appendNonEmptyA([[]], B,  C) :-
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
decrement([], SearchedName, []) :-
	!.
decrement([T|Q], SearchedName, NewList) :-
	[Name, Value] = T,
	decrementValue(Name, Value, SearchedName, DecrementedElem),
	decrement(Q, SearchedName, NewListRec),
	append(DecrementedElem, NewListRec, NewList).

%decrementValue(+Name, +Value, +SearchedName, -Elem)
decrementValue(SearchedName, Value, SearchedName, Elem) :-
	ValueTemp is Value-1,
	Elem = [[SearchedName, ValueTemp]].
decrementValue(Name, Value, SearchedName, Elem) :-
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
prendrePion([], Pos, [], ElemToRemove) :-
	!.
prendrePion([T|Q], 0, NewPiles, ElemToRemove) :-
	[Elem|Others] = T,
	ElemToRemove = Elem,
	prendrePion(Q, -1, TempNewPiles, ElemToRemove),
	appendNonEmptyA([Others], TempNewPiles, NewPiles).
prendrePion([T|Q], Pos, NewPiles, ElemToRemove) :-
	TempPos is Pos-1,
	prendrePion(Q, TempPos, TempNewPiles, ElemToRemove),
	append([T], TempNewPiles, NewPiles).


%randomElem(+Liste, -Element)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	-Elem:		ble
randomElem(Liste, Element) :-
    length(Liste, Size),
    random(0, Size, Index),
    nth0(Index, Liste, ElementValue),
    [Element, _] is ElementValue.



%printDoubleArray(+Bourse)
printDoubleArray([]).
printDoubleArray([H|T]) :-
	nth0(0, H, Value),
	nth0(1, H, Name),
	print(Value),
	write('\t'),
	print(Name), nl,
	printDoubleArray(T).
	











%take1(+Elem, -name, -newElem)
reduceNumber([Name,1], Name, []).
reduceNumber([Name, N], Name, [[Name, O]]) :-
	O is N-1.
	

takeElement(Marchandises, Elem, NewMarchandises) :-
	random_member(Marchandises, E),
	delete(Marchandises, E, Marchandises2),
	reduceNumber(E, Elem, NewE),
	append(Marchandises2, NewE, NewMarchandises).