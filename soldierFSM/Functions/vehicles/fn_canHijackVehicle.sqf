params["_man", "_vehicle"];
if((_vehicle distance _man) > SFSM_DodgeDistance)exitWith{false;};

private _type = [_vehicle] call objScan_fnc_VehicleType;
if!(_type in SFSM_hijackVehicleTypes) exitWith {false;};
if!(_type in SFSM_hijackArmourTypes)  exitWith {true;};

private _isCrewMan = "crew" in toLowerANSI typeOf _man;
if(_isCrewMan)exitWith{true;};

false;