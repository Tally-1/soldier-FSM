// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_hnkObjects", "_hunkerObjData"];
private _object = "";
{
    if([_x, _hunkerObjData] call SFSM_fnc_hunkAvailable)
    exitWith{_object = _x};

} forEach _hnkObjects;

if(_object == "")exitWith{};

_object