// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Gets a position laterally in relation to a enemy.

// Params: [_man:object(the one running), _enemy:object(The one he is hiding from), _distance:number]

// Return value: position

// Example: [_bluMan, _opMan, 40] call SFSM_fnc_getLateralPos;

private _distance = SFSM_DodgeDistance;
params['_man', '_enemy', '_distance'];
private _pos = getPos _man;
private _dir = _man getRelDir _enemy;
private _dirCorrection = selectRandom[90, -90];

_dir = [(_dir + _dirCorrection)] call Tcore_fnc_formatDir;

private _latPos = [_pos#0, _pos#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_latPos