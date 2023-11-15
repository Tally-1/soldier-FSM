// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_turret"];
_man assignAsGunner _turret;
[_man] orderGetIn true;
_man moveInGunner _turret;
private _eh = _turret addEventHandler ["GetOut", {_this spawn SFSM_fnc_onGetOutTurret}];
_turret setVariable ["SFSM_getOutEH", _eh];

true;