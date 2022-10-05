params ["_man"];
private _startPos = eyepos _man;
private _endPos = getPosWorld _man vectorAdd [0, 0, 10];
private _objs = lineIntersectsWith [_startPos, _endPos, _man, objNull, true];
if(_objs isEqualTo [])exitWith{};

private _house = _objs#0;

if(count _objs == 1
&& {_house isKindOf "house"})
exitWith{_house};

{
  if(_x isKindOf "house")
  exitWith{_house = _x};
  
} forEach _objs;

if!(_house isKindOf "house")exitWith{};

_house;