// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_battlefield", "_objectHash"];

if(isNil "_man")exitWith{};
if(isNull _man)exitWith{};

private _side           = side _man;
private _lastName      = ((name _man) splitString " ")#1;
private _enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

if(isNil "_lastName")then{_lastName = hashValue _man};
if(isNil "_lastName")exitWith{};

[_objectHash, _enemyPositions] call SFSM_fnc_setHobjPositions;
private _safePos = _objectHash get"safe_pos";
if(_safePos distance2D _man > 100)exitWith{};

_objectHash set ["owner", _lastName];
// doStop _man;
_man doFollow _man;

private _script = [_man, _safePos] spawn SFSM_fnc_moveToHunkerPos;
waitUntil{sleep 1; scriptDone _script};

if((eyePos _man) distance2d _safePos > 2)
exitWith{[_man, "action", "cannot reach hunker pos"] call SFSM_fnc_unitData};

[_man, "action", "hunker down"]     call SFSM_fnc_unitData;
[_man, "hunkObjectHash", _objectHash] call SFSM_fnc_unitData;

_man disableAI "PATH";
_man setUnitPos "DOWN";

true;