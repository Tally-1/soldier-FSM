// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_medic"];
private _woundedMen = (_medic nearEntities ["CAManBase", 99]) 
                select{
                [_medic, _x, false, 99, false] call SFSM_fnc_canBuddyHeal
                && {_x != _medic
                && {_x getVariable ["ace_isunconscious", false]
                }}};

if(_woundedMen isEqualTo [])exitWith{};

private _target = ([_woundedMen, [], {_medic distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

[_medic, _target] spawn  SFSM_fnc_buddyRevive;

true;