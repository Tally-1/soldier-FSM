// private _battlefieldCheck = false;
params["_man"];
if!(SFSM_overRun)exitWith{false;};

private _enemies = [_man,nil,nil,true] call SFSM_fnc_nearEnemies;
private _overRun = [_man, _enemies]    call SFSM_fnc_canBeOverRun;
if!(_overRun)exitWith{false;};

[_man, _enemies] spawn SFSM_fnc_overRun;

true;