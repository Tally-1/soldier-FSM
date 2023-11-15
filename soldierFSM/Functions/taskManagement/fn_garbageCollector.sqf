private _objects = SFSM_cleanupObjs select {[_x] call SFSM_fnc_validCleanupObject;};
SFSM_cleanupGrps = SFSM_cleanupGrps select {!isNull _x;};

{deleteVehicle _x;} forEach _objects;
{deleteGroup _x;}   forEach SFSM_cleanupGrps;

true;