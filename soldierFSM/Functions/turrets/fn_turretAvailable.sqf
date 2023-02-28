private _ignoreCrewVar = false;
params["_turret", "_ignoreCrewVar"];
if(damage _turret > 0.9)              exitWith{false;};
if!([_turret] call Tcore_fnc_deadCrew)exitWith{false;};

private _newGunner = _turret getVariable ["SFSM_gunner", objNull];
if((alive _newGunner) && {! _ignoreCrewVar})exitWith{false;};

true;