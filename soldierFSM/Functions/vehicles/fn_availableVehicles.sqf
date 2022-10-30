params["_pos", "_radius"];

private _availableVehicles = 
(_pos nearObjects ["car", _radius])
select {[_x] call SFSM_fnc_vehicleAvailable;};


_availableVehicles;