// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ['_man', '_coverPos'];
private _group = group _man;
private _canTakeCover = [_group] call SFSM_fnc_groupCanDodge;
private _lastCover   = [_man, "last_time_in_cover"] call SFSM_fnc_unitData;
if(isNil "_lastCover")                       exitWith{};
private _noCoverSpam = (time - _lastCover) > (SFSM_stayCoverPosTime + 120);
if(isNil "_noCoverSpam")                       exitWith{};
if (isNil '_coverPos')                         exitWith{'cover-pos is undefined, cannot take cover' call dbgmsg};
if(_noCoverSpam)                               exitWith{};
if (_man getVariable ['SFSM_excluded', false]) exitWith{};
if ([_man] call SFSM_fnc_isPlayer)             exitWith{};
if!([_man, true] call SFSM_fnc_canRun)         exitWith{};
if!(_canTakeCover)                             exitWith{[["taking cover blocked grp: ", _group]] call dbgmsg}; 


//wait until man is available
// private _script = 
[_man] call SFSM_fnc_initTakeCover;
// waitUntil{sleep 0.1; scriptDone _script};

if!([_man] call SFSM_fnc_manAvailable)
exitWith{'unit too busy to take cover' call dbgmsg};

if(_man call SFSM_fnc_unitInDoor 
&&{(! SFSM_dodgeIndoors)})
exitWith{"Cannot take cover, the unit is indoors" call dbgmsg};

private _target       = getAttackTarget _man;
private _behaviour = behaviour _man;
private _group     = group _man;

_group setSpeedMode "FULL";

if(stance _man == "prone") 
then{_man setUnitPos "MIDDLE"};

["take_cover_init", [_man, _coverPos]] call CBA_fnc_localEvent;


_man setAnimSpeedCoef SFSM_sprintSpeed;
[_man, "action", "taking cover"]    call SFSM_fnc_unitData;



// _script = 
[_man, _coverPos, SFSM_dodgeTimer, 2.5] call SFSM_fnc_forceMove2;
// waitUntil{sleep 0.1; scriptDone _script};

_man doTarget _target;
_man setUnitPos "AUTO";
_man doMove (getPos _man);

_man setAnimSpeedCoef 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "last_time_in_cover", time]    call SFSM_fnc_unitData;


[_man, _coverPos] spawn SFSM_fnc_endTakeCover;
true;