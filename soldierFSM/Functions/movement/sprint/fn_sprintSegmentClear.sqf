params[
	["_man", nil, [objNull]]
];

/*
Reducing the amount of checks to half, I may reduce this even further in the future.
*/
private _doCheck = [_man, "checkSprint"] call SFSM_fnc_unitData;
if(_doCheck isEqualTo false)exitWith{
	[_man, "checkSprint", true] call SFSM_fnc_unitData;
	true;
};

[_man, "checkSprint", false] call SFSM_fnc_unitData;

private _distance   = 3.5;
private _z          = 1.2;
private _dir        = getDirVisual _man;
private _startPos     = aimPos _man;
private _endPos     = ATLToASL([_startPos, _dir, _distance, _z] call SFSM_fnc_sinCosPos2);
private _objsInPath = (lineIntersectsSurfaces [_startPos, _endPos, _man, objNull, true, 3, "GEOM", "FIRE", true]) apply {_x#3};

_objsInPath = _objsInPath select {_x isKindOf "man" isEqualTo false;};

private _pathClear = _objsInPath isEqualTo [];

_pathClear;