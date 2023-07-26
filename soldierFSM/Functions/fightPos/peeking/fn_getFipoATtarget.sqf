params["_man"];
if!([_man] call SFSM_fnc_inFipo)      exitWith {objNull};
if!([_man] call SFSM_fnc_isATSoldier) exitWith {objNull};

private _targets = [_man] call SFSM_fnc_bffEnemyVehicles;
if(_targets isEqualTo [])exitWith{objNull};

_targets = _targets select {[_man, _x] call SFSM_fnc_targetVisible;};
if(_targets isEqualTo [])exitWith{objNull};

private _target = [_man, _targets] call SFSM_fnc_getNearest;

_target;