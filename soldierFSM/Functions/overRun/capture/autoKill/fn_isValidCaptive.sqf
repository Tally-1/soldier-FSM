params[
	["_man", nil, [objNull]]
];

if (isNil  "_man")                            exitWith{false;};
if!(_man getVariable ["SFSM_captive", false]) exitWith{false;};
if ([_man] call SFSM_fnc_canRun)              exitWith{false;};

true;