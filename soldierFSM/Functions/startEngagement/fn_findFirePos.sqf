params ["_man", "_targetPosASL"];

if(typeName _targetPosASL == "object")
then{
	    _targetPosASL = [(getPosASLVisual "object"), 1.5] call Tcore_fnc_addZ;

};

private _visibility = ([(aimPos _man), _targetPosASL] call Tcore_fnc_visibility);
if(_visibility >= 0.8)exitWith{(_man call Tcore_fnc_getPos)};

private _midPos = [(getPosASL _man), _targetPosASL] call Tcore_fnc_getMidpoint;
private _radius = _midPos distance2d _man;
private _searchPositions = [_midPos, _radius, 30, 1.5] call Tcore_fnc_squareGrid;
_searchPositions = [_man, _searchPositions] call Tcore_fnc_sortByDist;

private _firePos = [0,0,0];

{
	private _searchPos = AGLToASL _x;
	private _visibility = ([_searchPos, _targetPosASL] call Tcore_fnc_visibility);
	if(_visibility >= 0.4)exitWith{_firePos = _searchPos;};
	
} forEach _searchPositions;

_firePos;