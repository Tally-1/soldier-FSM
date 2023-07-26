private _objects = SFSM_cleanupObjs select 
	{[_x] call SFSM_fnc_validCleanupObject;};

{deleteVehicle _x;} forEach _objects;

SFSM_cleanupObjs = SFSM_cleanupObjs select {!isNull _x;};


true;