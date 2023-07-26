// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle", "_man"];

private _currentUnits = _vehicle getVariable ["targetedBy", []];

if(_currentUnits isEqualTo [])exitWith{false;};

private _otherSidePresent = false;

{
    if((side _x) != (side _man))
    exitWith{_otherSidePresent = true;};
    
} forEach _currentUnits;

_otherSidePresent;