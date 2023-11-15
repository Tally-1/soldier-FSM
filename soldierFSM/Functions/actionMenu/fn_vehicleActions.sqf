// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle"];
if(SFSM_hijackVehicles isNotEqualTo "action")exitWith{false;};

private _type = [_vehicle] call objScan_fnc_VehicleType;
if(isNil "_type")exitWith{false;};
if(!(_type in SFSM_hijackVehicleTypes))exitWith{false;};

[_vehicle] call SFSM_fnc_enableHijack;
[_vehicle] call SFSM_fnc_disableHijack;

true;