params["_man"];
private _victim = _man getVariable "SFSM_myExecVictim";
private _active = _man getVariable ["SFSM_abuser", false];

if ([_victim] call SFSM_fnc_isUncon) exitwith{false;};
if!(alive _victim)                   exitwith{false;};
if!(_active)                         exitwith{false;};

true;