params ["_man"];
private _action = [_man, "action"] call SFSM_fnc_unitData;
private _canDodge = [_man, true] call SFSM_fnc_canDodge;
if(isNil "_action")exitWith{false;};
if(_action != "none")exitWith{false;};
if!(_canDodge)exitWith{false;};

if(_man getVariable ["SFSM_Sprinting", false])exitwith{false;};

private   _target = getAttackTarget _man;
if(!alive _target)then{_target = _man findNearestEnemy _man;};
if(!alive _target)exitWith{false;};

if(_man distance2D _target > SFSM_CQBdistance)exitWith{false;};

private _targetHouse = [_target] call SFSM_fnc_currentBuilding;
if(isNil "_targetHouse")exitWith{false;};

private _houseFull = [_man, _targetHouse] call SFSM_fnc_CQBlimitReached;
private _rigged    = _targetHouse getVariable ["SFSM_explosiveRigged", false];
private _blowItUp  = [_man, _targetHouse] call SFSM_fnc_canBlowUpHouse;
private _sendIt    = [_man, _targetHouse] call SFSM_fnc_canRpgHouse;

if(_houseFull)exitWith{'House is already being cleared' call dbgmsg; false;};
if(_rigged)exitWith{'House is about to explode' call dbgmsg; false;};

if(_sendIt)
exitWith{
    [_man, _targetHouse] spawn SFSM_fnc_rpgHouse;
    true;
};

if(_blowItUp)
exitWith{
  [_man, _targetHouse] spawn SFSM_fnc_blowUpHouse;
  true;

};

if(_target getVariable ["ace_isunconscious", false])exitWith{false;};

_man doFire _target;
[_man, _targetHouse, _target] spawn SFSM_fnc_ClearBuilding;
true;