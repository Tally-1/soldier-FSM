// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle"];
if(SFSM_aceLoaded) exitWith{
   [_vehicle] remoteExecCall ["SFSM_fnc_ACE_enableHijack", 0, true];
};

private _condition = "Alive _target 
                   && {(!(_target getVariable ['SFSM_allowHijack', false]))
                   && {[_target] call Tcore_fnc_deadCrew}}";

private _title = "<t color='#f8aa45'>Allow vehicle hijacking.</t>";

[_vehicle,
[
    _title,        // title
    {
        params ["_vehicle", "_caller", "_actionId", "_arguments"]; 
        _vehicle setVariable ["SFSM_allowHijack", true, true];
        _vehicle setObjectTexture ["clan", ""];
        hint "This vehicle can now be hijacked by AI.";
    },
    nil,        // arguments
    1.5,        // priority
    true,       // showWindow
    true,       // hideOnUse
    "",         // shortcut
    _condition, // condition
    5,          // radius
    false,      // unconscious
    "",         // selection
    ""          // memoryPoint
]] 
remoteExecCall ["addAction", 0, true];