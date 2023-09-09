params[
	"_man", 
	"_target", 
	["_bullets", (ceil random 3)],
	["_aimAccuracy", 0.1]
];
private _hasAim = [_man, _target, _aimAccuracy] call SFSM_fnc_isAimedAtTarget;
if(_hasAim isEqualTo false)exitWith{false;};

[_man, _bullets] call SFSM_fnc_forcedFire;

true;