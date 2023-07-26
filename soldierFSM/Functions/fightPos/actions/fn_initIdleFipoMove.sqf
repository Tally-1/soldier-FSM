params["_man"];
private _doIdleMove = [_man] call SFSM_fnc_canDoIdleFipo;

if!(_doIdleMove)exitWith{false;};

_man setUnitPos "UP";
_man disableAI "anim";
[_man] spawn SFSM_fnc_idleFipoMan;

true;