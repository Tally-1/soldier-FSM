// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
private _timer = time + SFSM_reactFireCoolDown;
_man doWatch  objNull;
[_man, "reactFireTimer", _timer]    call SFSM_fnc_unitData;
[_man, "action", "none"]            call SFSM_fnc_unitData;
true;