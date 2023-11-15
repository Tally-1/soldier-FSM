// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle"];
if (isNil "_vehicle")                                 exitwith{false;};
if!(alive _vehicle)                                   exitwith{false;};
if!(canMove _vehicle)                                 exitwith{false;};
if!((locked _vehicle)in[0,1,3])                       exitwith{false;};
if!([_vehicle] call Tcore_fnc_deadCrew)               exitwith{false;};
if!(_vehicle getVariable ["SFSM_allowHijack", false]) exitwith{false;};


private _vehicleType      = [_vehicle] call objScan_fnc_VehicleType;
private _targetedBy       = _vehicle getVariable ["targetedBy", []];

if (_targetedBy isNotEqualTo [])             exitWith{false;};
if!(_vehicleType in SFSM_hijackVehicleTypes) exitwith{false;};

true;