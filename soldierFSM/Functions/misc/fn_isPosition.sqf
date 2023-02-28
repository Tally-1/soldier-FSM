params ["_array"];
if(isNil "_array")              exitWith{false;};
if!(typeName _array == "ARRAY") exitWith{false;};

private _2Dpos = _array isEqualTypeArray [0,0];
private _3Dpos = _array isEqualTypeArray [0,0,0];

private _validPosition = (_2Dpos || _3Dpos);

_validPosition;