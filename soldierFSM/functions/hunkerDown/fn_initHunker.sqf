// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
if!(SFSM_allowHunkerDown)exitWith{false;};

private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{false;};
private _action = [_man, "action"] call SFSM_fnc_unitData;
if("hunker" in _action)exitWith{false;};


if((leader (group _man) == _man)
&&{count(units (group _man)) > 1})exitWith{false;};

private _maxDistance    = (_battlefield get "radius")*2;
private _knownEnemies   = [_man, _maxDistance, 'enemies'] call Tcore_Fnc_nearKnownEnemies;
if(count _knownEnemies == 0)exitWith{false;};

private _hunkerObject = [_man, _battlefield] call SFSM_fnc_getHunkerObject;
if(isNull _hunkerObject)exitWith{false;};

private _objData = [_hunkerObject, _battlefield]   call SFSM_fnc_hunkObjHash;
if(isNil "_objData")exitWith{false;};

private _enemyVehicles = [];
private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
_enemyVehicles = _vehicles select 
                       {((side _x) != (side _man))
                       &&{(!([(side _x), (side _man)] call BIS_fnc_sideIsFriendly))
                       &&{!([_x] call Tcore_fnc_deadCrew)}}};


if(count _enemyVehicles > 0)
exitWith{false;};

[_man, _battlefield, _objData] spawn SFSM_fnc_hunkerFSM;

true;