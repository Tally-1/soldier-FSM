params["_vehicle"];
if!(SFSM_hijackVehicles)exitWith{false;};

private _type = [_x] call objScan_fnc_VehicleType;
if!(_type in SFSM_hijackVehicleTypes)exitWith{false;};

[_vehicle] call SFSM_fnc_enableHijack;
[_vehicle] call SFSM_fnc_disableHijack;
true;