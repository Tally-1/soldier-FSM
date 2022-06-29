params ["_man", "_battlefield", "_objectHash"];

private _side           = side _man;
private _lastName      = ((name _man) splitString " ")#1;
private _enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

[_objectHash, _enemyPositions] call SFSM_fnc_setHobjPositions;
_objectHash set ["owner", _lastName];
private _safePos = _objectHash get"safe_pos";

doStop _man;

private _script = [_man, _safePos] spawn SFSM_fnc_moveToHunkerPos;
waitUntil{sleep 1; scriptDone _script};

if((eyePos _man) distance2d _safePos > 2)
exitWith{[_man, "action", "cannot reach hunker pos"] call SFSM_fnc_unitData};

[_man, "action", "hunker down"] 	call SFSM_fnc_unitData;

_man disableAI "PATH";
_man setUnitPos "DOWN";

true;