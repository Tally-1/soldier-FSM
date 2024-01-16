// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _actionText = "none";
params ["_man", "_actionText"];

_man addEventHandler ["HandleHeal", {
    params ["_man", "_healer", "_isMedic"];
    [_man, "prevHealTime", time] call  SFSM_fnc_unitData;
    [_man, _thisEventHandler, _actionText] spawn SFSM_fnc_endSelfHeal; 
}];