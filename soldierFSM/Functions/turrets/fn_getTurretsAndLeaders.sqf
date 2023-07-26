// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicles", "_groups"];
private _turrets = _vehicles select {[_x] call SFSM_fnc_isTurret;};
private _leaders = ((_groups apply {leader _x}) select {[_x] call SFSM_fnc_isRealMan;});
[_turrets, _leaders];