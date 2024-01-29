params[
	["_fipo",   nil, [objNull]]
];
private _man = [_fipo] call SFSM_fnc_fipoMan;
if(isNil "_man")exitWith{objNull;};

private _inFipo = [_man, "inFipo"] call SFSM_fnc_unitData;
if!(_inFipo)                exitWith{objNull;};
if(_man distance _fipo > 5) exitWith{objNull;};

_man;