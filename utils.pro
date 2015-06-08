

emptyList([]).


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

%prendrePion(+Piles,-NewPiles,+Pos,-Elem)
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



%randomElem(+Liste, -Element)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	-Elem:		ble
randomElem(Liste, Element) :-
    length(Liste, Size),
    random(0, Size, Index),
    nth0(Index, List, ElementValue),
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