// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle", "_man"];
[_man, "action", "none"] call SFSM_fnc_unitData;
private _arr = (_vehicle getVariable "targetedBy");
(_vehicle getVariable "targetedBy") deleteAt (_arr find _man);
_man doMove (getPos _man);
_man doFollow (leader (group _man));

true;