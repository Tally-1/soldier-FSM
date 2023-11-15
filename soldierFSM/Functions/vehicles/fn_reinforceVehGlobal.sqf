private _units  = (entities "caManBase") select {[_x] call SFSM_fnc_availableAiSoldier;};
private _vehicles = (entities "car") select {
    [_x] call SFSM_fnc_vehicleNeedsCrew
    &&{([_x] call objScan_fnc_VehicleType) in SFSM_hijackVehicleTypes
}};
private _inUse    = [];
{
    private _nearestVehicle     = [_x, _vehicles] call SFSM_fnc_getNearest;
    if(isNil "_nearestVehicle")then{_nearestVehicle = objNull;};
    
    private _found              = typeName _nearestVehicle isEqualTo "OBJECT";
    private _needsReinforcement = _found && {[_nearestVehicle] call SFSM_fnc_vehicleNeedsCrew};
    private _sameSide           = _found && {((side _nearestVehicle) == (side _x))};

    if(_found
    &&{_needsReinforcement
    &&{_sameSide
    &&{(_nearestVehicle in _inUse) isEqualTo false}}})
    then{
            private _role = "gunner";
            if(alive (gunner _nearestVehicle))then{_role = "driver"};
            [_x, _nearestVehicle]        call  SFSM_fnc_joinVehGrp;
            [_x, _nearestVehicle, _role] spawn SFSM_fnc_getInVehicle;
            
            _inUse pushBackUnique _nearestVehicle;
    };

} forEach _units;

true;