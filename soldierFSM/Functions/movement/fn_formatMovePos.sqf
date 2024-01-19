params["_pos"];
_pos params [
	["_xx", nil, [0]],
	["_yy", nil, [0]],
	["_zz", 0.1, [0]]
];


if(_zz >= 0 &&{_zz < 1}) exitWith{_pos;};
if(_zz < 0)             exitWith{[_xx, _yy, 0.1]};
if(_zz > 10)            exitWith{[_xx, _yy, 0.1]};
private _building = [_pos] call SFSM_fnc_buildingOnPos;
private _inDoors  = !isNil "_building";

if(_inDoors && {_zz > 1})exitwith{_pos;};

[_xx, _yy, 0.1];