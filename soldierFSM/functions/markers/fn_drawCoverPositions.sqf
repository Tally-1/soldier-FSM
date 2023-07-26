// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_posArr", "_color"]; 
private _markers = [];

{
    private _marker = [_x, "", 0.4, _color, "mil_end_noShadow"] call SFSM_fnc_posMarker;
    _markers pushBackUnique _marker;
} forEach _posArr;

_markers;