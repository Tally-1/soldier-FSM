// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Selects type of flinch (stance change or drop to ground) based on projectile size. Then executes flinch.

params ["_man", "_bigProjectile", "_shooter"];
private _flinchFnc    = SFSM_fnc_standardFlinch;

//store coolDowntimer, and set flinching value.
[_man, "flinchTimer", (time + SFSM_FlinchCoolDown)] call SFSM_fnc_unitData;
[_man, "flinching", true]                           call SFSM_fnc_unitData;
[_man, "action", "reacting"]                        call SFSM_fnc_unitData;

if(_bigProjectile)then{_flinchFnc = SFSM_fnc_BigBulletFlinch};

private _reactionTime = [_man]     call _flinchFnc;
[_man, _reactionTime, _shooter] spawn SFSM_fnc_endFlinch;
[_man] call SFSM_fnc_registerFlinch;

["flinch", [_man]]   call CBA_fnc_localEvent;

if([_man] call SFSM_fnc_isPinnedDown)then{
    ["pinned_down", [_man]]   call CBA_fnc_localEvent;
};

true;