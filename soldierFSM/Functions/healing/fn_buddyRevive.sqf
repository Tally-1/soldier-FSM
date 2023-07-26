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

//set action-data
private _startPos    = getPos _healer;
private _healerName  = name _healer;
private _woundedName = name _unconscious;
private _wPos        = [getPosATL _unconscious, 0.2] call Tcore_fnc_addZ;
private _timeLimit   = 30;

if(_timeLimit < SFSM_DodgeTimer)then{_timeLimit = SFSM_DodgeTimer};

private _timer       = time + _timeLimit;

private _hAction = ["reviving ", _woundedName]joinString "";
private _wAction = ["being revived by ", _healerName]joinString "";

[_healer, _hAction] call SFSM_fnc_setAction;
[_unconscious, _wAction] call SFSM_fnc_setAction;

["buddy_revive_init", [_healer, _unconscious]] call CBA_fnc_localEvent;

private _run = [_healer, _wPos, _timeLimit, 3] spawn SFSM_fnc_forceMove2;
waitUntil{ sleep 1; (scriptDone _run || time > _timer);};

//check if conditions are still valid, if not then abort revive
private _canHeal = [_healer, _unconscious, true, 7, true] call SFSM_fnc_canBuddyHeal;
if(! _canHeal)exitWith{
    [_healer, _unconscious, false] call SFSM_fnc_endBuddyRevive;
};


private _relocatePos = [_healer, _unconscious] call SFSM_fnc_dragPos;

if (!isNil "_relocatePos") then {
    private _timeAdded = round((_unconscious distance2D _relocatePos) * 1.2);
    _timer             = _timer + _timeAdded;
    private _drag      = [_healer, _unconscious, _relocatePos] spawn SFSM_fnc_dragMan;
    
    waitUntil { sleep 1; scriptDone _drag;};
};

if(! _canHeal)exitWith{
    [_healer, _unconscious, false] call SFSM_fnc_endBuddyRevive;
};

//revive
["revive_anim", [_healer, _unconscious]] call CBA_fnc_localEvent;
private _healing = [_healer, _unconscious] spawn SFSM_fnc_reviveAnim;
waitUntil{
        sleep 1; 
        scriptDone _healing;
};

private _canHeal = [_healer, _unconscious, true, 7] call SFSM_fnc_canBuddyHeal;
if(! _canHeal)exitWith{
        [_healer, _unconscious, false] call SFSM_fnc_endBuddyRevive;
};

[_unconscious, false] call ace_medical_fnc_setUnconscious;
[_healer, _unconscious] call ace_medical_treatment_fnc_fullHeal;
[_healer, _unconscious, true] call SFSM_fnc_endBuddyRevive;
true;