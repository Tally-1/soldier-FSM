//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_battlefield"];
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _hnkObjects    = missionNamespace getVariable (_battlefield get "hunkerObjects");
private _activeSides   = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
{
    [_x, _battlefield, _hunkerObjData, _hnkObjects] call SFSM_fnc_filterHunkerObjects;
} forEach _activeSides;

true;