params["_center", "_posArr"];
_posArr = _posArr select {_center isNotEqualTo _x};
private _count = count _posArr;

if(_count isEqualTo 0)exitWith{};
if(_count isEqualTo 1)exitWith{_posArr#0;};

([_posArr, [], {_center distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;