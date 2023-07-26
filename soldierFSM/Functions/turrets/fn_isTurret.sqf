// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_vehicle"];
private _vehicleType = [_vehicle] call objScan_fnc_VehicleType;

private _turret = (_vehicleType in ["static (HMG)", "static (GMG)"]
                &&{!isAutonomous _vehicle});

_turret;