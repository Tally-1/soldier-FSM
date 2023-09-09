params["_man"];
private _destination = _man getVariable "SFSM_SprintDestination";
if (_man distance2D _destination < 1.7)          exitWith{false;};
if([_man, "abortSprint"] call SFSM_fnc_unitData) exitWith{false;};
if!([_man, true] call SFSM_fnc_canRun)           exitWith{false;};

true;