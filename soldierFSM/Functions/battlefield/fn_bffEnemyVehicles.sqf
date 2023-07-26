params["_man"];
private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{[]};

private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
if(_vehicles isEqualTo [])exitWith{[]};
_vehicles = _vehicles select {[_man, _x] call SFSM_fnc_validEnemyVehicle;};

_vehicles;