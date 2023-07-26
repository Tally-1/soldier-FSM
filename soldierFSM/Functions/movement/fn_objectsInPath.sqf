// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _dist = 2;
params[
    "_man", 
    "_dir",
    "_dist"    
];

private _pos    = aimPos _man;
private _vPos = [_man, _dir, _dist] call SFSM_fnc_relAimPos;
private _objsInPath = lineIntersectsObjs [_pos, _vPos, _man, objNull, true, 3];

_objsInPath;