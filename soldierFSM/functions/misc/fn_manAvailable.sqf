// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _timer = time + 5;
params["_man", "_timer"];

private _action   = [_man, "action"] call SFSM_fnc_unitData;
private _timedOut = time > _timer;

if(!alive _man)         exitwith{true};
if(_timedOut)        exitwith{true};
if(isNil '_action')  exitwith{true};
if(_action == "none")exitwith{true};
false;