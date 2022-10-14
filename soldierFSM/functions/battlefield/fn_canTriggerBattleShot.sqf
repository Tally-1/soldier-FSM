params ["_unit"];
if!([_unit] call SFSM_fnc_isRealMan)exitWith{false;};

private _lastBullet = [_unit, "last_bullet_fired"] call SFSM_fnc_unitData;
if(time - _lastBullet < 2)exitwith{false};

private _battle = [_unit, "currentBattle"] call SFSM_fnc_unitData;
if!(_battle == "none")exitwith{false};

private _lastBattle = [_unit, "lastBattle"] call SFSM_fnc_unitData;
if(time - _lastBattle < 10)exitwith{false};

private _target = getAttackTarget _unit;
if(isNull _target)exitwith{false};
if!([_target] call SFSM_fnc_isRealMan)exitWith{false;};

private _initData = [_unit, _target] call SFSM_fnc_battleInitType;
if!(_initData#0 == "start")exitwith{false};


true;