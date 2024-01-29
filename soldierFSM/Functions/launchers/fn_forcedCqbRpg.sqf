params["_man"];
if(time - ([_man, "lastCqbRpgCheck"] call SFSM_fnc_unitData) < 60) exitWith{};
[_man, "lastCqbRpgCheck", time] call SFSM_fnc_unitData;

private _target = (getAttackTarget _man);

if (_man distance2D _target < 20)             exitWith{};
if!(alive _target)                            exitWith{};
if!([_man] call SFSM_canRpgHouse)             exitWith{};
if!([_man, _target] call SFSM_fnc_validEnemy) exitWith{};



private _targetBuilding = [_target] call SFSM_fnc_currentBuilding;
if(isNil "_targetBuilding")exitWith{};

private _validTarget = [_targetBuilding] call SFSM_fnc_validRpgTargetBuilding;
if!(_validTarget)exitWith{};

"Attacking building with RPG" call dbgmsg;
[_man, _targetBuilding] spawn SFSM_fnc_rpgHouse;