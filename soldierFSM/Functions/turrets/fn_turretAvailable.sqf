// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _ignoreCrewVar = false;
params["_turret", "_ignoreCrewVar"];
if(damage _turret > 0.9)              exitWith{false;};
if!([_turret] call Tcore_fnc_deadCrew)exitWith{false;};

private _newGunner = _turret getVariable ["SFSM_gunner", objNull];
if((alive _newGunner) && {! _ignoreCrewVar})exitWith{false;};

true;