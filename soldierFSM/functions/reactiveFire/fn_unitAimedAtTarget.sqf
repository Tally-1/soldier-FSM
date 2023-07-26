// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _vectorCalc     = false;
private _maxDeviation     = 3;
params["_shooter", "_target", "_maxDeviation", "_vectorCalc"];
private _dir         = [_shooter] call SFSM_fnc_unitWeaponDir;
private _targetDir     = (_shooter getRelDir _target) + _dir;

private _trueAim = [_dir, _targetDir] call SFSM_fnc_inDirRange; 

_trueAim