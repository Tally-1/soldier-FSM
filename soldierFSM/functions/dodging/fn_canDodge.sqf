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
if!(SFSM_allowDodging)                               exitWith{false};
if!([_man, true] call SFSM_fnc_canRun)               exitWith{false};
if([_man] call SFSM_fnc_isPlayer)                    exitWith{false};
if(_man getVariable ["SFSM_Sprinting", false])       exitwith{false;};

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{false;};

private _group             = group _man;
private _grpCanDodge       = [_group] call SFSM_fnc_groupCanDodge;
private _dodgeTimer        = [_man, "dodgeTimer"]         call SFSM_fnc_unitData;
private _pathEnabeled        = [_man, 'pathEnabeled']     call SFSM_fnc_unitData;
private _rps               = [_man, "roundsPrSecond"]     call SFSM_fnc_unitData;
private _coolDownEnded     = _dodgeTimer < time;
private _lowSuppression       = getSuppression _man < SFSM_ProneTreshHold;
private _highRPS           = (_rps > SFSM_RpsDodgeTrigger) || _noRpsParam;

private _canDodge = (_coolDownEnded
                    &&{(_action == 'none')
                    &&{_lowSuppression
                    &&{_highRPS
                    &&{_grpCanDodge
                    &&{_pathEnabeled}}}}});

_canDodge;