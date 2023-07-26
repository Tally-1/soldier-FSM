// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Determines if a unit can heal another unit. 

// Return value: boolean

// Example: [_man1, _man2] call SFSM_fnc_canHeal;


private _ignoreAction = false;
private _maxDistance  = SFSM_medicSearchDistance;
private _excludeConscious = false;
params[
    "_healer",             //object(man)
    "_woundedMan",        //object(man)
    "_ignoreAction",     //bool (ignore current action set by SFSM_fnc_unitData)
    "_maxDistance",     //number (max distance between healer and wounded)
    "_excludeConscious"//bool (exclude conscious units)
    ];
private _hSide = side _healer;
private _wSide = side (group _woundedMan);

if ([_healer] call SFSM_fnc_isPlayer)                                              exitWith{false;};//non ai cannot be forced to heal
if (_hSide != _wSide && {_wSide != civilian})                                      exitWith{false;};//wounded is enemy
if (_healer distance2D _woundedMan > _maxDistance)                                 exitWith{false;};//to far away 
if (_excludeConscious && {!(_woundedMan getVariable ["ace_isunconscious", false])})exitWith{false;};//Wounded does not need revive
if!(alive _woundedMan)                                                             exitWith{false;};//wounded man died 

if ([_healer] call SFSM_fnc_isFipoMedic)                                           exitWith{true;}; //Medics in fighting positions will detach and heal

if!([_healer] call SFSM_fnc_canRun)                                                exitWith{false;};//healer cannot move
if!([_healer] call SFSM_fnc_canSelfHeal)                                           exitWith{false;};//healer cannot heal

//all conditions except actions have been met, return true unless action is not ignored.
if(_ignoreAction)exitWith{true;};


if!([_healer, "action"] call SFSM_fnc_unitData isEqualTo "none")                  exitWith{false;};//healer is busy.
if!([_woundedMan, "action"] call SFSM_fnc_unitData isEqualTo "none")              exitWith{false;};//wounded is busy.


true;