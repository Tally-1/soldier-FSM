// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

//this whole file should probably be cleaned up, it is basically a clone of doHideCQB.
params ["_man", "_enemyVehicle", "_CQB"];
if(_CQB)exitWith{[_man, _enemyVehicle] spawn SFSM_fnc_doHideCQB;};

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(_action isNotEqualTo "none")
then{
    private _timer = time+20;
    waitUntil {
        sleep 1;
        _action = [_man] call SFSM_fnc_getAction;
        _action isEqualTo "none" || time > _timer
    };
};

private _coverPos = [_man] call SFSM_fnc_getCoverPos;
if(!isNil "_coverPos")
then{
      _man doMove (getPos _man);
      _man doTarget objNull;
      [_man, "action", "moving to cover for hiding"] call SFSM_fnc_unitData;
      _man setAnimSpeedCoef SFSM_sprintSpeed;
      [_man, _coverPos] call SFSM_fnc_forcedMove;
      _man setAnimSpeedCoef 1;
};
private _coverTime   = [_man, SFSM_hidingTimeOut] call SFSM_fnc_getCourageTime;
private _timer       = time + _coverTime;
private _exitStatus  = "";
private _behaviour   = combatBehaviour _man;
private _combatMode  = unitCombatMode _man;
private _ovEnemy     = objNull;

_man disableAI 'path';
_man setCombatBehaviour "STEALTH";
_man setUnitCombatMode "WHITE";
_man setUnitPos "DOWN";

[_man, "action", 'holding hide-position'] call SFSM_fnc_unitData;
["hiding_start", [_man, _enemyVehicle]]   call CBA_fnc_localEvent;

while{_exitStatus == ""}do{
    if (time > _timer)                              exitWith{_exitStatus = "timed out";};
    if (!alive _man)                                exitWith{_exitStatus = "man died";};
    if ([_enemyVehicle] call Tcore_fnc_deadCrew)    exitWith{_exitStatus = "Vehicle neutralized."};
    if!(isNull ([_man] call SFSM_fnc_manOverrunBy)) exitWith{_exitStatus = "overrun";};
    if([_man]call SFSM_fnc_isUncon)                 exitWith{_exitStatus = "man is unconscious";};


    // private _script = 
    [_man, 5] call SFSM_fnc_CQBTargetEnemies;
    // waitUntil {sleep 1; scriptDone _script; };
    _man setCombatBehaviour "STEALTH";
    _man setUnitCombatMode "WHITE";
    _man setUnitPos "DOWN";
    _man doTarget objNull;
};

_text = ["leaving hide-position, ", _exitStatus]joinString"";
[_man, "action", _text] call SFSM_fnc_unitData;
sleep 2;

[_man, "action", "none"] call SFSM_fnc_unitData;
["hiding_end", [_man, _enemyVehicle]]   call CBA_fnc_localEvent;

_man enableAI 'path';
_man setCombatBehaviour _behaviour;
_man setUnitCombatMode _combatMode;
_man setUnitPos "AUTO";
_man setAnimSpeedCoef 1;

if((alive _ovEnemy)
&&{[_man, true] call SFSM_fnc_canDodge})
then{[_man, _ovEnemy] spawn SFSM_fnc_Dodge;};

true;