//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:  Parses a string into a side array 
// Params:       _string - string to be parsed
// Return value: _sides - [WEST, EAST, RESISTANCE, CIVILIAN]

// Example:     _sides = "[WEST, EAST, RESISTANCE, CIVILIAN]" call SFSM_fnc_sidesFromString;

private _string = _this;

// (typeName _string) call dbgmsg;
// _string call dbgmsg;
private _stringArr = _string splitString "[,]";
private _sides = [];

{
    if!(_x == "GUER")then{_sides pushBack (call compile _x)}
                     else{_sides pushBack independent};
} forEach _stringArr;

_sides