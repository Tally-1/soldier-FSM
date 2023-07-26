// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_vehicle"];
private _allowHijack = _vehicle getVariable "SFSM_allowHijack";

if(isNil "_allowHijack")then{
    _vehicle setVariable ["SFSM_allowHijack", true, true];
};

[_vehicle] call SFSM_fnc_vehicleFiredEh;
[_vehicle] call SFSM_fnc_vehicleActions;

if([_vehicle]call Tcore_fnc_deadCrew)exitWith{};

private _vehicleData = createHashMap;
_vehicleData set     ["currentBattle", "none"];
_vehicleData set     ["hiddenPos", []];

_vehicle setVariable ["SFSM_vehicleData", _vehicleData, true];

_vehicleData;