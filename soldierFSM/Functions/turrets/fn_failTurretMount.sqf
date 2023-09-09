// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_turret", "_reason"];
private _msg = ["Turret-mount failed! ", _reason]joinString"";
[_turret, _man]call SFSM_fnc_removeTurretVars;
[_man, _msg, 3] spawn SFSM_fnc_flashAction;
[[_msg],2] call dbgmsg;
true;