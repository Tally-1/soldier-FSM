// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_battlefield"];
private _side = side _man;
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _hnkObjects    = missionNamespace getVariable (_battlefield get "hunkerObjects");

if(isNil "_hnkObjects")exitWith{"no hunker objects yet, loading data" call sfsm_fnc_debugmessage; objNull};

private _nearObjects     = _hnkObjects inAreaArray [(getPos _man), SFSM_DodgeDistance, SFSM_DodgeDistance];
private _approvedObjects = [_side, _battlefield, _hunkerObjData, _hnkObjects] call SFSM_fnc_filterHunkerObjects;
_approvedObjects = _approvedObjects select {_x in _nearObjects};
private _objCount        = count _approvedObjects;
if(_objCount == 0)exitWith{"no hunker objects found" call sfsm_fnc_debugmessage; objNull};


private _nearest = [_man, _approvedObjects] call Tcore_fnc_nearestPos;

_nearest;