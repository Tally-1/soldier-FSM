params["_man"];
if!([_man] call SFSM_fnc_availableAiSoldier)exitWith{false;};

private _cooldownEnded = time-([_man, "huntEnded"] call SFSM_fnc_unitData) > SFSM_huntCooldown;
if!(_cooldownEnded)exitWith{false;};

true;