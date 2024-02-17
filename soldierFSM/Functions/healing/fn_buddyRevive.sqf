// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Used with ACE medical. A soldier drags a unconscious soldier to a safe location and revives him.
// Params: [_healer:object(man), _unconscious:object(man)]
// Return value: none
// Example: [_healer, _unconscious] spawn SFSM_fnc_buddyRevive;

params["_healer", "_unconscious"]; 

if([_healer] call SFSM_fnc_isFipoMedic)then{
    private _fipo = [_healer] call SFSM_fnc_getFipo;
    _healer setVariable ["SFSM_myFipo", _fipo];
    [_healer] call SFSM_fnc_getOutFipo;
};

["buddy_revive_init", [_healer, _unconscious]] call CBA_fnc_localEvent;


private _startPos      = getPos _healer;
private _healerName    = name _healer;
private _woundedName   = name _unconscious;
private _wPos          = [getPosATL _unconscious, 0.2] call Tcore_fnc_addZ;
private _distance      = _healer distance _unconscious;
private _inSmokeDist   = _distance < 40 && {_distance > 10};
private _maxDistance   = _distance*1.25;
private _moveCondPar   = [_healer, _unconscious, _maxDistance];
private _moveCondition = [_moveCondPar, SFSM_fnc_canMoveToRevive];
private _hAction       = ["reviving ", _woundedName]joinString "";
private _wAction       = ["being revived by ", _healerName]joinString "";

//set action-data
[_healer, _hAction]      call SFSM_fnc_setAction;
[_unconscious, _wAction] call SFSM_fnc_setAction;

// Add eventhandler to set cooldown if healer dies.
[_healer, _unconscious] call SFSM_fnc_buddyReviveDeathEh;


if(_inSmokeDist)then{[_healer, _unconscious] call SFSM_fnc_deploySmokeOnMan;};
[_healer, _wPos, nil, 3, _moveCondition] call SFSM_fnc_forcedMove;

//check if conditions are still valid, if not then abort revive
private _canHeal = [_healer, _unconscious, true, 7, true] call SFSM_fnc_canBuddyHeal;
if!(_canHeal)exitWith{[_healer, _unconscious, false] call SFSM_fnc_endBuddyRevive;};

[_healer, _unconscious] call SFSM_fnc_relocateUnconMan;

_canHeal = [_healer, _unconscious, true, 7, true] call SFSM_fnc_canBuddyHeal;
if!(_canHeal)exitWith{[_healer, _unconscious, false] call SFSM_fnc_endBuddyRevive;};

//start reviving
_healer disableAI "MOVE";
["revive_anim", [_healer, _unconscious]] call CBA_fnc_localEvent;
[_healer, _unconscious] call SFSM_fnc_reviveAnim;
_healer enableAI "MOVE";

private _canHeal = [_healer, _unconscious, true, 7] call SFSM_fnc_canBuddyHeal;
if(! _canHeal)exitWith{
        [_healer, _unconscious, false] call SFSM_fnc_endBuddyRevive;
};

[_unconscious, false] call ace_medical_fnc_setUnconscious;
[_healer, _unconscious] call ace_medical_treatment_fnc_fullHeal;
[_healer, _unconscious, true] call SFSM_fnc_endBuddyRevive;

[_healer, _unconscious] call SFSM_fnc_moraleOnRevive;

true;