//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: determines if a unit is able to start a battle with another unit.

// Params: [_unit:object, _target:object]

// Return value: boolean

// Example: [_unit, _target] call SFSM_fnc_canSpotInitBattle;

params ["_unit", "_target"];
if!([_unit] call SFSM_fnc_isRealMan)    exitWith{false};
if!([_target] call SFSM_fnc_isRealMan)  exitWith{false};
if ([_unit] call SFSM_fnc_isUncon)      exitWith{false};
if ([_target] call SFSM_fnc_isUncon)    exitWith{false};

private _lastBullet = [_unit, "last_bullet_fired"] call SFSM_fnc_unitData;
if(isNil "_lastBullet")    exitwith{false;};
if(time - _lastBullet < 2) exitwith{false;};

private _battle = [_unit, "currentBattle"] call SFSM_fnc_unitData;
if!(_battle == "none")exitwith{false};

private _lastBattle = [_unit, "lastBattle"] call SFSM_fnc_unitData;
if(time - _lastBattle < 10)exitwith{false};

private _initData = [_unit, _target] call SFSM_fnc_battleInitType;
if!(_initData#0 == "start")exitwith{false};

if!([_unit, _target] call SFSM_fnc_bffKnowEachOther)exitwith{false};

true;