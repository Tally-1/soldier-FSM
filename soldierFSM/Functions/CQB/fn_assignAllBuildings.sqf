//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_battleField"];
_battlefield set ["currentAction",    "Assigning buildings"];
private _units = missionNamespace getVariable (_battlefield get "units");

{[_x] call SFSM_fnc_assignBuilding;} forEach _units;

_battlefield set ["currentAction",    "none"];

true;