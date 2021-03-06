params ["_man", "_bigProjectile", "_shooter"];
private _flinchFnc    = SFSM_fnc_standardFlinch;

//store coolDowntimer, and set flinching value.
[_man, "flinchTimer", (time + SFSM_FlinchCoolDown)] call SFSM_fnc_unitData;
[_man, "flinching", true] 							call SFSM_fnc_unitData;
[_man, "action", "reacting"] 						call SFSM_fnc_unitData;

if(_bigProjectile)then{_flinchFnc = SFSM_fnc_BigBulletFlinch};

private _reactionTime = [_man] 	call _flinchFnc;
[_man, _reactionTime, _shooter] spawn SFSM_fnc_endFlinch;

true;