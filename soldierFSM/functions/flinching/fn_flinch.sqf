params ["_man", "_bigProjectile"];
private _flinchFnc = Tally_fnc_standardFlinch;

//store coolDowntimer, and set flinching value.
[_man, "flinchTimer", (time + SFSM_FlinchCoolDown)] call Tally_Fnc_SFSM_unitData;
[_man, "flinching", true] 							call Tally_Fnc_SFSM_unitData;
[_man, "action", "flinch"] 							call Tally_Fnc_SFSM_unitData;

if(_bigProjectile)then{_flinchFnc = Tally_fnc_BigBulletFlinch};

[_man] call _flinchFnc;
[_man] spawn Tally_fnc_endFlinch;

true;