//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params ["_unit"];
// if(time - SFSM_lastShotFired < 2) exitWith {};

private _startBattle = [_unit] call SFSM_fnc_canTriggerBattleShot;
if!(_startBattle)exitWith{};

private _target = getAttackTarget _unit;
[_unit, _target] call SFSM_fnc_InitBattlefield;

true;