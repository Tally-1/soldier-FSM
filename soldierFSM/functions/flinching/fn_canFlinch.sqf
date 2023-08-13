// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:

// Params:

// Return value:

// Example:

// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Checks if a unit can flinch. 

// Params: [_man:object(the unit in question)]

// Return value: boolean (true if the unit can flinch, false if not)

// Example: private _canFlinch = [_mySoldado] call SFSM_fnc_canFlinch;

params ["_man"];
if!(SFSM_allowFlinching)                           exitWith{false;}; 
if!([_man] call SFSM_fnc_availableAiSoldier)       exitWith{false;}; 

private _flinchTimer = [_man, "flinchTimer"] call SFSM_fnc_unitData;
private _canFlinch   = (_flinchTimer < time);


_canFlinch;