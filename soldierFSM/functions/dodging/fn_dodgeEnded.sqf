// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: determines if a unit has finished dodging.

// Params: [_man: object(the one running), _endPos: position(his desired destination), _timer: number (the time when the dodge will be forced to end)]

// Return value: boolean (true if the unit has finished dodging, false if not)

// Example: 
//         private _timer = (time + 15);
//         [_mySoldier, [0,0,0], ] call SFSM_fnc_dodgeEnded;

params ["_man", "_endPos", "_timer"];

if(isNil "_endPos")    exitWith{true};
if(isNil "_man")    exitWith{true};
if(!alive _man)        exitWith{true};
if(time > _timer)    exitWith{true};
if((_man distance2D _endPos) < (2))exitWith{true};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if(_action in ["reacting", "flinch"])
exitWith{true};


false