params["_battlefield"];
private _unitFilter = { (typeOf _x == (typeOf (vehicle _x))) &&{([_x, "action"]call SFSM_fnc_unitData)=="none"}};
private _units = missionNamespace getVariable (_battlefield get "units") select _unitFilter;
private _pos = _battlefield get "center";
private _radius = _battlefield get "radius";
private _vehicleFilter = {
	private _type = [_x] call objScan_fnc_VehicleType;
	(_type in SFSM_hijackVehicleTypes
	&&{[_x] call SFSM_fnc_vehicleNeedsCrew})
};
private _vehicles = (_pos nearEntities ["car", _radius]) select _vehicleFilter;

{
	private _nearestVehicle = [_x, _vehicles] call Tcore_fnc_nearestPos;
	private _found = typeName _nearestVehicle == "OBJECT";
	private _needsReinforcement = _found && {[_nearestVehicle] call SFSM_fnc_vehicleNeedsCrew};
	private _sameSide = _found && {((side _nearestVehicle) == (side _x))};

	if(_found
	&&{_needsReinforcement
	&&{_sameSide}})
	then{
            private _role = "gunner";
			if(alive (gunner _nearestVehicle))then{_role = "driver"};
            [_x, _nearestVehicle, _role] spawn SFSM_fnc_getInVehicle;
    };

	sleep 0.05;
} forEach _units;

true;