//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Sends a AI unit to clear a building from enemies, 3 methods are used to clear the building:
                // 1. Set explosives and blow the building up
                // 2. Fire a missile at the building
                // 3. Clear the building room by room

// Params: [_man:object(the ai unit that will clear a building)]

// Return value: boolean (true if the FSM was executed, false if not)

// Example: [_man] call SFSM_fnc_initCQB;

params ["_man"];
if!([_man] call SFSM_fnc_availableAiSoldier) exitWith{false;};

private   _target = getAttackTarget _man;
if!([_man, _target] call SFSM_fnc_validEnemy)then{
  private _enemies = [_man, SFSM_CQBdistance, nil, true] call SFSM_fnc_nearEnemies;
  _target = [_man, _enemies] call SFSM_fnc_getNearest;
};

if(isNil "_target")                            exitWith{false;};
if(!alive _target)                             exitWith{false;};
if(_man distance2D _target > SFSM_CQBdistance) exitWith{false;};

private _targetHouse = [_target] call SFSM_fnc_currentBuilding;
if(isNil "_targetHouse")exitWith{false;};

private _houseFull = [_man, _targetHouse] call SFSM_fnc_CQBlimitReached;
private _rigged    = _targetHouse getVariable ["SFSM_explosiveRigged", false];
private _blowItUp  = [_man, _targetHouse] call SFSM_fnc_canBlowUpHouse;
private _sendIt    = [_man, _targetHouse] call SFSM_fnc_canRpgHouse;

if(_houseFull)exitWith{'House is already being cleared' call dbgmsg; false;};
if(_rigged)exitWith{'House is about to explode' call dbgmsg; false;};

["cqb_init", [_man, _targetHouse]] call CBA_fnc_localEvent;

if(_sendIt)
exitWith{
    [_man, _targetHouse] spawn SFSM_fnc_rpgHouse;
    ["CQB_rpg", [_man, _targetHouse]] call CBA_fnc_localEvent;
    true;
};

if(_blowItUp)
exitWith{
  [_man, _targetHouse] spawn SFSM_fnc_blowUpHouse;
  ["CQB_explosive", [_man, _targetHouse]] call CBA_fnc_localEvent;
  true;

};


if(SFSM_clearHouse isEqualTo false) exitWith{false;};
if([_target] call SFSM_fnc_isUncon) exitWith{false;};

_man doFire _target;
[_man, _targetHouse, _target] spawn SFSM_fnc_ClearBuilding;
["CQB_clearing", [_man, _targetHouse, _target]] call CBA_fnc_localEvent;
true;