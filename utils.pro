

emptyList([]).


%decrement(+List,+Elem,-NewList)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	+Elem:		sucre
%	-NewList:	[[sucre,2],[ble,1]]
%	Exemple:
%	+List:		[[sucre,1],[ble,1]]
%	+Elem:		sucre
%	-NewList:	[[ble,1]]

%increment(+List,+Elem,-NewList)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	+Elem:		sucre
%	-NewList:	[[sucre,4],[ble,1]]
%	Exemple:
%	+List:		[[ble,1]]
%	+Elem:		sucre
%	-NewList:	[[sucre,1],[ble,1]]

%randomElem(+List,-Elem)
%	Exemple:
%	+List:		[[sucre,3],[ble,1]]
%	-Elem:		ble

%prendrePion(+Piles,-NewPiles,+Pos,-Elem)
%	Exemple:
%	+Pile:		[[sucre,riz,ble],[cacao,cafe],[mais]]
%	-NewPile	[[sucre,riz,ble],[cafe],[mais]]
%	+Pos:		1
%	-Elem:		cacao
%	Exemple:
%	+Pile:		[[sucre,riz,ble],[cacao,cafe],[mais]]
%	-NewPile	[[sucre,riz,ble],[cafe]]
%	+Pos:		2
%	-Elem:		mais



%random_member(+Liste, -Element)
random_member(Liste, Element) :-
    length(Liste, Size),
    random(0, Size, Index),
    nth0(Index, Liste, ElementValue),
    [Element, _] is ElementValue.

%take1(+Elem, -name, -newElem)
reduceNumber([Name,1], Name, []).
reduceNumber([Name, N], Name, [[Name, O]]) :-
	O is N-1.
	

takeElement(Marchandises, Elem, NewMarchandises) :-
	random_member(Marchandises, E),
	delete(Marchandises, E, Marchandises2),
	reduceNumber(E, Elem, NewE),
	append(Marchandises2, NewE, NewMarchandises).