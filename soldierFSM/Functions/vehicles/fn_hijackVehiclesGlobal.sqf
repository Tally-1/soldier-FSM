private _vehicles = (entities "car") select {
    [_x] call SFSM_fnc_vehicleAvailable
    &&{_x getVariable ["SFSM_allowHijack",false]
    }};

if(_vehicles isEqualTo [])exitWith{};

private _units  = (entities "caManBase") select {[_x] call SFSM_fnc_availableAiSoldier;};

_units = [_units, _vehicles, SFSM_DodgeDistance] call SFSM_fnc_UnitsNearVehicles;
if(_units isEqualTo [])exitWith{};

private _hijackers = [];

{
    private _newHijackers = [_x, _units, _hijackers] call SFSM_fnc_hijackVehicle;
 
    if(!isNil "_newHijackers")
    then{_hijackers append _newHijackers;};
    
} forEach _vehicles;

true;