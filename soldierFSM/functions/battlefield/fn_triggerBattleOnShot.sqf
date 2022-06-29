params ["_unit"];
// if(time - SFSM_lastShotFired < 2) exitWith {};

private _startBattle = [_unit] call SFSM_fnc_canTriggerBattleShot;
if!(_startBattle)exitWith{};

private _target = getAttackTarget _unit;
[_unit, _target] call SFSM_fnc_InitBattlefield;

true;