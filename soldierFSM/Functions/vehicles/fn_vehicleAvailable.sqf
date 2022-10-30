params["_vehicle"];
if(isNil "_vehicle")exitwith{false;};
if(!alive _vehicle)exitwith{false;};
if(!canMove _vehicle)exitwith{false;};
// if(!canFire _vehicle)exitwith{false;}; //(vehicles with no crew returns false on can fire)
if!([_vehicle] call Tcore_fnc_deadCrew)exitwith{false;};
if!((locked _vehicle)in[0,1,3])exitwith{false;};

private _occupiedVehicles = [];
private _vehicleType = [_vehicle] call objScan_fnc_VehicleType;

private _targetedBy = _vehicle getVariable ["targetedBy", []];

if(count _targetedBy>1)exitWith{false;};
if!(_vehicleType in SFSM_hijackVehicleTypes)exitwith{false;};

true;