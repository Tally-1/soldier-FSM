params["_man"];
if!(_man getVariable ["SFSM_SprintAnimUpdates", false])exitWith{};

private _enemies = [_man] call SFSM_fnc_enemiesInFront;
if(_enemies isEqualTo [])exitWith{};

private _target = _enemies#0;
[_man, _target, 4, 1] call SFSM_fnc_ifAimThenFire;