
%iaJouer(+Bourse,+Piles,+Trader,+Reserve,+OtherReserve,-Dist,-Prendre)
iaJouer(Bourse, Piles, Trader, Reserve, OtherReserve, Dist, Prendre) :-
	length(Piles, L1),
	nth0(Trader, Piles, TempPile1),
	nth0(0, TempPile1, Elem_a),
	Trader2  is (Trader + 1) mod L1,
	nth0(Trader2, Piles, TempPile2),
	nth0(0, TempPile2, Elem_b),
	Trader3  is (Trader + 2) mod L1,		
	nth0(Trader3, Piles, TempPile3),
	nth0(0, TempPile3, Elem_c),
	Trader4  is (Trader + 3) mod L1,		
	nth0(Trader4, Piles, TempPile4),
	nth0(0, TempPile4, Elem_d),

	emptyList(Diffs),

	%Test Dist 1, Prendre 0
	increment(Reserve, Elem_a, TempReserve1),
	decrement(Bourse, Elem_c, TempBourse1),
	getPlayerPoints(TempBourse1, TempReserve1, MyScore1),
	getPlayerPoints(TempBourse1, OtherReserve, OtherScore1),
	Diff1 is MyScore1-OtherScore1,
	append(Diffs, [[Diff1,1,0]], TempDiffs1),

	%Test Dist 1, Prendre 1
	increment(Reserve, Elem_c, TempReserve2),
	decrement(Bourse, Elem_a, TempBourse2),
	getPlayerPoints(TempBourse2, TempReserve2, MyScore2),
	getPlayerPoints(TempBourse2, OtherReserve, OtherScore2),
	Diff2 is MyScore2-OtherScore2,
	append(TempDiffs1, [[Diff2,1,1]], TempDiffs2),

	%Test Dist 2, Prendre 0
	increment(Reserve, Elem_b, TempReserve3),
	decrement(Bourse, Elem_d, TempBourse3),
	getPlayerPoints(TempBourse3, TempReserve3, MyScore3),
	getPlayerPoints(TempBourse3, OtherReserve, OtherScore3),
	Diff3 is MyScore3-OtherScore3,
	append(TempDiffs2, [[Diff3,2,0]], TempDiffs3),

	%Test Dist 2, Prendre 1
	increment(Reserve, Elem_d, TempReserve4),
	decrement(Bourse, Elem_b, TempBourse4),
	getPlayerPoints(TempBourse4, TempReserve4, MyScore4),
	getPlayerPoints(TempBourse4, OtherReserve, OtherScore4),
	Diff4 is MyScore4-OtherScore4,
	append(TempDiffs3, [[Diff4,2,1]], TempDiffs4),

	msort(TempDiffs4, OrderedDiffs),
	nth0(3, OrderedDiffs, [_, Dist, Prendre]).
