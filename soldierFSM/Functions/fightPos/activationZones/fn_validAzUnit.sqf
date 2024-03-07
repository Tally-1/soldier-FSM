params["_entity"];

if!(_entity inArea (_self get "area"))     exitWith{false;};
if!((side _entity) in (_self get "sides")) exitWith{false;};

private _isMan     = [_entity] call SFSM_fnc_functionalMan;
private _isVehicle = [_entity] call SFSM_fnc_validVehicle;
private _inValid   = _isMan isEqualTo false && {_isVehicle isEqualTo false};

if(_inValid)exitWith{false;};


true;