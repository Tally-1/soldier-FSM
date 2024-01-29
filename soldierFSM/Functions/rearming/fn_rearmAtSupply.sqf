// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_supplyObject"];

if(isNil "_supplyObject")exitWith {[_man, false] spawn SFSM_fnc_endRearm;};
if(isNull _supplyObject)exitWith  {[_man, false] spawn SFSM_fnc_endRearm;};

private _supplyPos = getPos _supplyObject;
if!([_supplyPos] call SFSM_fnc_isPosition)exitWith {[_man, false] spawn SFSM_fnc_endRearm;};

[_man, "currentDestination", _supplyPos] call SFSM_fnc_unitData;
[_man, "action", "rearming"] call SFSM_fnc_unitData;

_man setAnimSpeedCoef SFSM_sprintSpeed;

private _pos = getPos _supplyObject;
_pos = [_pos#0,_pos#1, (_pos getDir _man), 1] call SFSM_fnc_sinCosPos;

[_man, _pos, 60, 3] call SFSM_fnc_forcedMove;


private _stillValid = [_man, _supplyObject] call SFSM_fnc_validRearm;

if(! _stillValid) exitWith {[_man, false] spawn SFSM_fnc_endRearm;};

_man action ["rearm", _supplyObject];

[_man, true] spawn SFSM_fnc_endRearm;

true;