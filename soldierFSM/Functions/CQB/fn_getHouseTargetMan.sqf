params[
    ["_shooter",  nil, [objNull]],
    ["_building", nil, [objNull]]
];

private _targetMan = _shooter getVariable ["SFSM_prevTarget", objNull];
if!([_shooter, _targetMan] call SFSM_fnc_validEnemy)exitWith{
   [player, _building] call SFSM_fnc_nearestEnemyInBuilding;
};

private _targetBuilding = [_targetMan] call SFSM_fnc_currentBuilding;
if(isNil "_targetBuilding")      exitWith {[_shooter, _building] call SFSM_fnc_nearestEnemyInBuilding};
if(_targetBuilding != _building) exitWith {[_shooter, _building] call SFSM_fnc_nearestEnemyInBuilding};

_targetMan;