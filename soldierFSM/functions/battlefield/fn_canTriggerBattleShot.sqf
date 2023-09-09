//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: determines if a battle should start when a man.
// Params: _unit: Object - the unit to check
// Return value: Boolean - true if a battle should start, false otherwise
// Example: [_unit] call SFSM_fnc_canTriggerBattleShot;

params ["_unit"];
if!([_unit] call SFSM_fnc_isRealMan)exitWith{false;};
if ([_unit] call SFSM_fnc_isUncon)  exitWith{false;};

private _lastBullet = [_unit, "last_bullet_fired"] call SFSM_fnc_unitData;
if(isNil "_lastBullet")   exitwith{false;};
if(time - _lastBullet < 2)exitwith{false;};

private _battle = [_unit, "currentBattle"] call SFSM_fnc_unitData;
if(_battle isNotEqualTo "none")exitwith{false};

private _lastBattle = [_unit, "lastBattle"] call SFSM_fnc_unitData;
if(time - _lastBattle < 10)exitwith{false};

private _target = getAttackTarget _unit;
if(isNull _target)exitwith{false};
if!([_target] call SFSM_fnc_isRealMan)exitWith{false;};

private _initData = [_unit, _target] call SFSM_fnc_battleInitType;
if!(_initData#0 == "start")exitwith{false};


true;