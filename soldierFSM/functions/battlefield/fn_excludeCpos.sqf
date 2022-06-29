params["_positions"];
private _excluded = [];

{
	private _nearest = [_x, _positions] call Tcore_fnc_nearestPos;
	if(_nearest distance2D _x < 1.2
	&&{!(_nearest isEqualTo _x)})
	then{_excluded pushBackUnique _x};
} forEach _positions;

systemChat (["posEqual =", (_excluded isEqualTo _positions)]joinString"");

_excluded;