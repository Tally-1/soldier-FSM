params[
	["_man", nil, [objNull]]
];
private _lastFlinchSprint = [_man, "lastFlinchSprint"] call SFSM_fnc_unitData;
private _timeSince        = time - _lastFlinchSprint;
if(_timeSince <  30)                exitWith{false;};
if((random 1) <= 0.3)               exitWith{false;};
if!([_man] call SFSM_fnc_canRun)    exitWith{ 
	[_man, "lastFlinchSprint", time] call SFSM_fnc_unitData;
	false;
};

true;