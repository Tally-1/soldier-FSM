params ["_vehicle"];
private _vehicleType = [_vehicle] call objScan_fnc_VehicleType;

private _turret = (_vehicleType in ["static (HMG)", "static (GMG)"]
                &&{!isAutonomous _vehicle});

_turret;