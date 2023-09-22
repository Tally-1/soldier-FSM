params["_ATLpos"];
private _startPos = ATLToASL _ATLpos;
private _endPos = _startPos vectorAdd [0, 0, 10];
private _objs = lineIntersectsWith [_startPos, _endPos, objNull, objNull, true];

// check to the front and left as well.
_endPos = _startPos vectorAdd [0, 5, 0];
_objs append (lineIntersectsWith [_startPos, _endPos, objNull, objNull, true]);
_endPos = _startPos vectorAdd [5, 0, 0];
_objs append (lineIntersectsWith [_startPos, _endPos, objNull, objNull, true]);

if(_objs isEqualTo [])exitWith{};

private _house = _objs#0;

if(count _objs isEqualTo 1
&& {_house isKindOf "house"})
exitWith{_house};

{
  if(_x isKindOf "house")
  exitWith{_house = _x};
  
} forEach _objs;

if!(_house isKindOf "house")exitWith{};

_house;