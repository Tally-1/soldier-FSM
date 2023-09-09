params["_man", "_target"];
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man doTarget objNull;
_man setDir (_man getDir _target);
_man disableAI "anim";

[_man, "forcedMovement", true] call SFSM_fnc_unitData;
_man setVariable ["SFSM_myAttackTarget", _target];
_man setVariable ["SFSM_evasiveAttack",  true];

true;