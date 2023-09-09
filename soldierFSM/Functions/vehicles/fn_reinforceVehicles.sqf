// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_battlefield"];
private _unitFilter = { (typeOf _x == (typeOf (vehicle _x))) &&{([_x, "action"]call SFSM_fnc_unitData)=="none"}};
private _units = missionNamespace getVariable (_battlefield get "units") select _unitFilter;
private _pos = _battlefield get "center";
private _radius = _battlefield get "radius";
private _vehicleFilter = {
    private _type = [_x] call objScan_fnc_VehicleType;
    ((_type in SFSM_hijackVehicleTypes)
    &&{[_x] call SFSM_fnc_vehicleNeedsCrew})
};
private _vehicles = (_pos nearEntities ["car", _radius]) select _vehicleFilter;
private _inUse    = [];
{
    private _inUse     = [_x, _vehicles] call Tcore_fnc_nearestPos;
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
            [_x, _nearestVehicle, _role] spawn SFSM_fnc_getInVehicle;
            
            _inUse pushBackUnique _nearestVehicle;
    };

} forEach _units;

true;