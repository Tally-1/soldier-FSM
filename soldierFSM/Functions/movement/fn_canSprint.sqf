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

if(isNil "_man")                                   exitwith{false;};
if(isNil "_pos")                                   exitwith{false;};
if(isNil "_action")                                exitWith{false;};
if(_man in allPlayers)                             exitwith{false;};
if([_man, "inFipo"] call SFSM_fnc_unitData)        exitWith{false;};
if(_man distance2D _pos < _minDist)                exitWith{false;};
if(_man distance2D _pos > _maxDist)                exitWith{false;};
if(! ([_man] call SFSM_fnc_isRealMan))             exitwith{false;};
if(count SFSM_sprinters >= SFSM_maxSprinters)      exitWith{false;};
if(_man getVariable ["SFSM_Sprinting", false])     exitwith{false;};
if ([_man] call SFSM_fnc_isUncon)                  exitWith{false;};
if!([_man, "pathEnabeled"] call SFSM_fnc_unitData) exitWith{false;};
if(insideBuilding _man > 0)                        exitWith{false;};
if([_man, "abortSprint"] call SFSM_fnc_unitData)   exitWith{false;};
if(_man getVariable ["SFSM_Excluded",false])       exitWith{false;};
if(captive _man)                                   exitWith{false;};
if!([_man, _pos] call SFSM_fnc_clearSprintPath)    exitWith{false;};


true;