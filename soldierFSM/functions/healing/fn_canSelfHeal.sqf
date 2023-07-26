// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Checks if the unit is allowed to heal himself. 

// Params: [_man:object(man)]

// Return value: boolean

// Example: [_mySoldaddy] call SFSM_fnc_canSelfHeal;
private _playerCheck = false;
params ["_man", "_playerCheck"];

if!([_man, true, true, true] call SFSM_fnc_canRun) exitWith{false};
if!([_man] call SFSM_fnc_hasMedKit)                exitWith{false};

if(_playerCheck)exitWith{true};

if(SFSM_EmergencyHealing isEqualTo "disabeled")exitWith{false};

true;