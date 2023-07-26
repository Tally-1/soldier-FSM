//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Assigns available units to perform CQB actions when conditions are met

// Params: _battleField (hashmap) - battlefield object

// Return value: true

// Example: [_battleField] call SFSM_fnc_battleFieldCQB;


params ["_battleField"];

_battlefield set ["currentAction",    "Assigning CQB"];
private _units = missionNamespace getVariable (_battleField get "units");

{
  private _script = [_x] spawn SFSM_fnc_initCQB;
  waitUntil{sleep 0.02; scriptDone _script};
  
} forEach _units;
_battlefield set ["currentAction",    "none"];
true;