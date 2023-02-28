params["_man", "_turret"];
[_turret, _man]call SFSM_fnc_removeTurretVars;
[_man, "Turret-mount failed!", 3] call SFSM_fnc_flashAction;
true;