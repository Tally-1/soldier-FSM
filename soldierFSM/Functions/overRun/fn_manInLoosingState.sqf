params[
	["_man", nil, [objNull]]
];
private _available = [_man, true] call SFSM_fnc_canRun;
if(_available isEqualTo false)exitWith{false;};

private _surrounded = [_man] call SFSM_fnc_isSurrounded;
if(_surrounded isEqualTo false)exitWith{false;};

private _battleLost = [group _man] call SFSM_fnc_battleLost;
if(_battleLost isEqualTo false)exitWith{false;};

true;