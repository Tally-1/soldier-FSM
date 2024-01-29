params["_man"];
private _target = _man getVariable "SFSM_myAttackTarget";

_man setDir (_man getDir _target);
[_man] call SFSM_fnc_fixPos;

sleep 0.1;

if([_man, _target, 3] call SFSM_fnc_ifAimThenFire)then{sleep 1;};

_man setAnimSpeedCoef 1;
_man setDir (_man getDir _target);
_man enableAI "anim";

[_man, "forcedMovement", false] call SFSM_fnc_unitData;
_man setVariable ["SFSM_myAttackTarget", nil];
_man setVariable ["SFSM_evasiveAttack",  nil];

true;