// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _maxDist = 100;
private _minDist = 3;
params ["_man", "_pos", "_maxDist", "_minDist"];
private _action = [_man, "action"] call SFSM_fnc_unitData;
private _canSprint = true;

isNil{//forced unscheduled execution

if(isNil "_man")                                   exitwith{_canSprint = false;};
if(isNil "_pos")                                   exitwith{_canSprint = false;};
if(isNil "_action")                                exitwith{_canSprint = false;};
if(_man in allPlayers)                             exitwith{_canSprint = false;};
if([_man, "inFipo"] call SFSM_fnc_unitData)        exitwith{_canSprint = false;};
if(_man distance2D _pos < _minDist)                exitwith{_canSprint = false;};
if(_man distance2D _pos > _maxDist)                exitwith{_canSprint = false;};
if(! ([_man] call SFSM_fnc_isRealMan))             exitwith{_canSprint = false;};
if(count SFSM_sprinters >= SFSM_maxSprinters)      exitwith{_canSprint = false;};
if(_man getVariable ["SFSM_Sprinting", false])     exitwith{_canSprint = false;};
if ([_man] call SFSM_fnc_isUncon)                  exitwith{_canSprint = false;};
if!([_man, "pathEnabeled"] call SFSM_fnc_unitData) exitwith{_canSprint = false;};
if([_man, "abortSprint"] call SFSM_fnc_unitData)   exitwith{_canSprint = false;};
if(_man getVariable ["SFSM_Excluded",false])       exitwith{_canSprint = false;};
if(captive _man)                                   exitwith{_canSprint = false;};
if!([_man, _pos] call SFSM_fnc_clearSprintPath)    exitwith{_canSprint = false;};

private _house = [_man] call SFSM_fnc_currentBuilding;
if(!isNil "_house") exitwith{_canSprint = false;};

};

_canSprint;