// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_enemyVehicle"];
private _text = "CQB: holding hide-position "; 
private _timer = time + SFSM_hidingTimeOut;
private _exitStatus = "";
private _behaviour = combatBehaviour _man;
private _combatMode = unitCombatMode _man;
private _ovEnemy = objNull;

_man disableAI 'path';
_man setCombatBehaviour "STEALTH";
_man setUnitCombatMode "WHITE";
_man setUnitPos "DOWN";

[_man, "action", _text] call SFSM_fnc_unitData;

while{_exitStatus == ""}do{
    if (time > _timer)exitWith{_exitStatus = "timed out";};
    if (!alive _man)exitWith{_exitStatus = "man died";};
    if ([_enemyVehicle] call Tcore_fnc_deadCrew)exitWith{_exitStatus = "Vehicle neutralized."};
    _ovEnemy = [_man] call SFSM_fnc_manOverrunBy;
    if!(isNull _ovEnemy)exitWith{_exitStatus = "overrun";};
    if(_man getVariable ["ace_isunconscious", false])exitWith{_exitStatus = "man is unconscious";};
    if(_man getVariable ["dam_ignore_injured0",false])exitWith{_exitStatus = "man is injured";};

    // private _script = 
    [_man, 5] call SFSM_fnc_CQBTargetEnemies;
    // waitUntil {sleep 5; scriptDone _script; };
    _man setUnitPos "DOWN";
    _man doTarget objNull;
};

_text = ["leaving hide-position, ", _exitStatus]joinString"";
[_man, "action", _text] call SFSM_fnc_unitData;
sleep 2;

[_man, "action", "none"] call SFSM_fnc_unitData;

_man enableAI 'path';
_man setCombatBehaviour _behaviour;
_man setUnitCombatMode _combatMode;
_man setUnitPos "AUTO";


if((alive _ovEnemy)
&&{[_man, true] call SFSM_fnc_canDodge})
then{[_man, _ovEnemy] spawn SFSM_fnc_Dodge;};

true;