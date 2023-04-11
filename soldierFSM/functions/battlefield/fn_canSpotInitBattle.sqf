params ["_unit", "_target"];
if!([_unit] call SFSM_fnc_isRealMan)exitWith{false};
if!([_target] call SFSM_fnc_isRealMan)exitWith{false};
if(_unit getVariable ["ace_isunconscious", false])exitWith{false;};
if(_target getVariable ["ace_isunconscious", false])exitWith{false;};
if(_unit getVariable ["dam_ignore_injured0",false])exitWith{false;};
if(_target getVariable ["dam_ignore_injured0",false])exitWith{false;};

private _lastBullet = [_unit, "last_bullet_fired"] call SFSM_fnc_unitData;
if(time - _lastBullet < 2)exitwith{false};

private _battle = [_unit, "currentBattle"] call SFSM_fnc_unitData;
if!(_battle == "none")exitwith{false};

private _lastBattle = [_unit, "lastBattle"] call SFSM_fnc_unitData;
if(time - _lastBattle < 10)exitwith{false};

private _initData = [_unit, _target] call SFSM_fnc_battleInitType;
if!(_initData#0 == "start")exitwith{false};


true;