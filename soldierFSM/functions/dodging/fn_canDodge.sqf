// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Determines wether or not a AI man is available to dodge, also used in a variety of other functions.

// Params: [_man: Object, _noRpsParam(If recent incoming fire should be accounted for, default False): Boolean]

// Return value: Boolean

// Example: [cursorObject, true] call SFSM_fnc_canDodge;

private _noRpsParam = false;
params ["_man", "_noRpsParam"];
if!(SFSM_allowDodging)                              exitWith{false};
if([_man, "inFipo"] call SFSM_fnc_unitData)         exitWith{false};
if([_man, "forcedMovement"] call SFSM_fnc_unitData) exitWith{false};

private _rps     = [_man, "roundsPrSecond"] call SFSM_fnc_unitData;
private _lowRPS  = (_rps < SFSM_RpsDodgeTrigger) || _noRpsParam;
if(_lowRPS) exitWith{false;};

private _proneTreshHold = [_man] call SFSM_fnc_getProneTreshHold;
private _suppressed     = getSuppression _man > _proneTreshHold;
if(_suppressed)exitWith{false;};

private _available = [_man] call SFSM_fnc_availableAiSoldier;
if!(_available)exitWith{false};

private _dodgeTimer = [_man, "dodgeTimer"] call SFSM_fnc_unitData;
if(_dodgeTimer > time)exitWith{false;};

private _mode = unitCombatMode _man;
if(_mode == "RED")   exitWith {true;};
if(_mode == "WHITE") exitWith {true;};

private _grpCanDodge = [group _man] call SFSM_fnc_groupCanDodge;
if!(_grpCanDodge) exitWith{false;};

true;