params ["_man"];
if!([_man, true] call SFSM_fnc_canRun) exitWith{true;};
if ([_man] call SFSM_fnc_forcedRegroup)exitWith{true;};

private _action = [_man] call SFSM_fnc_getAction;
if (_action isEqualTo "Forced regroup") exitWith {true;};


false;