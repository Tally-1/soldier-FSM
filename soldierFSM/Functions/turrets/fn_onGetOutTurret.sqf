// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_turret", "_role", "_man"];

private _myVehicle = _man getVariable "SFSM_myVehicle";//set in the proneHeal function
if(isNil "_myVehicle")exitWith{
    [_turret, _man]call SFSM_fnc_removeTurretVars;
};

sleep 6;

if([_turret] call Tcore_fnc_deadCrew)then{
    [_turret, _man]call SFSM_fnc_removeTurretVars;
};