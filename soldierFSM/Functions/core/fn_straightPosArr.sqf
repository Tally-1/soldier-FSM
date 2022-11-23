private _posCount = 10;
private _includeEnds = true;
params ["_start", "_end", "_posCount", "_includeEnds", "_zValue"];
private _positions = [];
private _dir = _start getDir _end;
private _dist = _start distance2D _end;
private _iterationDist = _dist / _posCount;
private _distToNextPos = _iterationDist;

for "_i" from 1 to _posCount do 
{
	private _newPos = [_start#0, _start#1, _dir, _distToNextPos] call Tcore_fnc_sinCosPos;

	if!(isNil "_zValue")then{_newPos = [_newPos#0, _newPos#1, _zValue]};

	_positions pushBack _newPos;
	_distToNextPos = _distToNextPos + _iterationDist;
};

if!(_includeEnds)exitWith{_positions;};

private _returnArr = [_start];
_returnArr append _positions;
_returnArr pushBack _end;

_returnArr;