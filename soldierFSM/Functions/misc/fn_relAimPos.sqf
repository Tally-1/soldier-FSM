// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _dist = 2;
params["_man", "_dir", "_dist"];
private _pos    = aimPos _man;
private _nDir   = [((getDir _man) - _dir)] call Tcore_fnc_formatDir;
private _nPos = [_pos#0, _pos#1, _nDir, _dist] call Tcore_fnc_sinCosPos;
_nPos = [_nPos#0, _nPos#1, _pos#2];
_nPos;