// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_battleField"];
private _unkillableVehicle = objNull; 
private _enemyVehicles     = [_man, _battleField] call SFSM_fnc_getEnemyVehicles;

if(_enemyVehicles isEqualTo []) exitWith {objNull};

private _highThreatVehicles = [];

{
    private _vehicleData   = [_x] call objScan_fnc_vehicleData;
    private _chassisClass  = (_vehicleData get "chassis") get "chassisID";
    private _weaponClasses = _vehicleData get "weaponTypes";
    private _bestWeapon    = selectMax _weaponClasses;
    private _operational   = !([_x] call Tcore_fnc_deadCrew);

    if(_operational
    &&{_bestWeapon >= 3
    &&{_chassisClass >= 1.2}})
    then{_highThreatVehicles pushBackUnique _x};

} forEach _enemyVehicles;


if(_highThreatVehicles isEqualTo []) exitWith {objNull};

_unkillableVehicle = [_man, _highThreatVehicles] call Tcore_fnc_nearestPos;

if(typeName _unkillableVehicle == "SCALAR")exitWith{objNull};

_unkillableVehicle;