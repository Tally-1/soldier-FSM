params ["_battlefield"];
Private _groups = missionNamespace getVariable (_battlefield get "groups");
private _allUnits = [];
{_allUnits append (units _x);} forEach _groups;

private _targets  = _allUnits select{[_x] call SFSM_fnc_isHVT};
private _center   = _battlefield get "center";
private _radius   = _battlefield get "radius";
private _vehicles = _center nearEntities ["staticWeapon", _radius];
private _turrets  = _vehicles select {[_x] call SFSM_fnc_isTurret;};
private _gunners  = (_turrets apply {gunner _x})select{[_x] call SFSM_fnc_isRealMan};

_targets append _gunners;

if(_targets isEqualTo []) exitWith{[]};

_targets;