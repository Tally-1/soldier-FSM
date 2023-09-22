params["_pos"];
_pos params ["_xx", "_y", "_z"];
if(_z >= 0 &&{_z < 1}) exitWith{_pos;};
if(_z < 0)             exitWith{[_xx, _y, 0.1]};
if(_z > 10)            exitWith{[_xx, _y, 0.1]};
private _building = [_pos] call SFSM_fnc_buildingOnPos;
private _inDoors  = !isNil "_building";

if(_inDoors && {_z > 1})exitwith{_pos;};

[_xx, _y, 0.1];