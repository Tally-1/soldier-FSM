// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Returns what kind of explosives an AI soldier is carrying in his backpack.

// Params:      [_man:object]

// Return value: _carriedExplosives:array[string]

// Example:      [_mySoldado] call SFSM_fnc_carriedExplosives;

params["_man"];
private _carriedExplosives = [];
{
    if(_x in SFSM_explosives)
    exitWith{_carriedExplosives pushback _x};
    
} forEach backpackItems _man;


_carriedExplosives;