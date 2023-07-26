// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: ends the buddy heal action.

// Return value: none

// Example: [_healer, _wounded, true] call SFSM_fnc_endBuddyHeal;

params[
    "_healer",   // Object(man): the healer
    "_wounded", // Object(man): the wounded
    "_success" // Boolean: true if the heal was successful, false if not
];

private _status = "successful!";
if!(_success)then{_status = "failed!";};
private _actionText = ["healing ", _status] joinString "";

_healer  enableAI "path";
_wounded enableAI "path";

[_healer, "action", _actionText] call SFSM_fnc_unitData;
[_wounded, "action", _actionText] call SFSM_fnc_unitData;

sleep 2;

[_healer, "action", "none"] call SFSM_fnc_unitData;
[_wounded, "action", "none"] call SFSM_fnc_unitData;

["healing_done", [_healer, _wounded, _success]] call CBA_fnc_localEvent;



true;