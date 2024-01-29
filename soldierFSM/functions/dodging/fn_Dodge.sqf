// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Makes an ai soldier run to cover if available, if not he will run diagonally away from the enemy.

// Params: [_man:object(the one running), _enemy:object(who he is hiding from), _seekCover:bool(look for cover)]

// Return value: scripthandle

// Example: [_bluMan1, _opMan1, true] spawn SFSM_fnc_Dodge;

private _seekCover = true;
params ["_man", "_enemy", "_seekCover"];

//I would normally prefer putting this codeBlock in the "canDodge" function,
//But since "unitInDoor" is using the "lineIntersectsSurfaces" command I have to put it here
//for performance reasons.
if(_man call SFSM_fnc_unitInDoor 
&&{(! SFSM_dodgeIndoors)})
exitWith{"indoor dodge blocked" call dbgmsg};

private _action = [_man] call SFSM_fnc_getAction;

if(isNil "_action")                  exitwith{};
if("dodging" in toLowerANSI _action) exitWith{};

if([_man] call SFSM_fnc_canDodge isEqualTo false)exitWith{};

// If the soldier runs to a nearby FIPO
if([_man, _enemy] call SFSM_fnc_initDodgeToFipo)exitWith{};

// New evasion function 
if(_seekCover isEqualTo false)exitWith{
    // Forced unscheduled execution
    // https://community.bistudio.com/wiki/call
    isNil {[_man, _enemy] call SFSM_fnc_evasion;};
};

private _dodgeToHouse = false;
//random chance to init CQB cover (50%)
if(random 1 > 0.5)
then{
      private _house = [(getPos _man), SFSM_DodgeDistance] call SFSM_fnc_nearestAvailableHouse;
      if (isNil '_house') exitWith {};
      private _coverPos = [_man, _house, true] call SFSM_fnc_moveIntoHouseInit;
      if!(_coverPos isEqualTo [0,0,0])
      then{
        _dodgeToHouse = true;
        ["dodge_indoor", [_man, _house, _enemy]]   call CBA_fnc_localEvent;
    };
};

if(_dodgeToHouse)exitWith{};

/*Set values to the unitData hashmap */
private _coolDown = (time + SFSM_DodgeCoolDown);
[_man, "dodgeTimer", _coolDown]      call SFSM_fnc_unitData;
[_man, "dodging",      true]         call SFSM_fnc_unitData;


private _target      = getAttackTarget _man;
private _behaviour   = behaviour _man;
private _timer       = time + SFSM_DodgeTimer;
private _dodgePos    = [_man, _enemy] call SFSM_fnc_GetDodgePos;
private _action      = "dodging";

private _coverRadius = SFSM_DodgeDistance / 2;
private _coverLatPos = [_man, _enemy, _coverRadius] call SFSM_fnc_getLateralPos;
private _coverPos    = [_man, _coverLatPos, _coverRadius] call SFSM_fnc_getCoverPos;
private _coverFound  = (!isNil "_coverPos" && {typeName _coverPos == 'ARRAY'});
private _group       = group _man;

if(_coverFound isEqualTo false)exitWith{
    // Forced unscheduled execution
    // https://community.bistudio.com/wiki/call
    isNil {[_man, _enemy] call SFSM_fnc_evasion;};
};

// if(_coverFound
// &&{_seekCover})
// then{
        _dodgePos = _coverPos;
        _action   = "dodging to cover";
    // };

// if(_action isEqualTo "Evading fire")exitWith{
//     [_man, _enemy] call SFSM_fnc_initEvadeFire;
// };

[_man, "currentDestination", _dodgePos] call SFSM_fnc_unitData;
[_man, "action", _action]    call SFSM_fnc_unitData;
["dodge_outdoor", [_man, _dodgePos, _enemy]] call CBA_fnc_localEvent;

//this new better method is far better than the old one.
if!(SFSM_flinchStopDodge)exitWith{

    // private _move = 
    [_man, _dodgePos, SFSM_DodgeTimer] call SFSM_fnc_forcedMove;
    // waitUntil{sleep 0.1; scriptDone _move;};

    _man doMove _dodgePos;
    [_man, _dodgePos, _timer, _target] spawn SFSM_fnc_EndDodge;
    true;
};


if(SFSM_forceDodge)
then{
    _man disableAI "TARGET";
    _man disableAI "AUTOCOMBAT";
    _man disableAI "AUTOTARGET";

    _man doTarget objNull;

if(stance _man == "prone")then{_man setUnitPos "MIDDLE"};
};



_man setAnimSpeedCoef SFSM_sprintSpeed;
_group setSpeedMode 'FULL';
_man doMove _dodgePos;



[_man, _dodgePos, _timer, _target] spawn SFSM_fnc_EndDodge;

true;