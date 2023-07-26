// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


private _dodgeDir = selectRandom ["right", "left"]; 
params ["_man", "_enemy", "_dodgeDir"];
private _XX             = (getPos _man) # 0;
private _YY             = (getPos _man) # 1;
private _dir             = _man getRelDir _enemy;
private _dirCorrection    = -90;

if(_dodgeDir == "right")then{_dirCorrection = 90};

private _newDir     = (_dir + _dirCorrection);
private _dodgePos     = [_XX, _YY, _newDir, SFSM_DodgeDistance] call SFSM_fnc_sinCosPos;


_dodgePos