// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: gets a safe position to drag a wounded unit to.

// Params: [_wounded:object(man)]

// Return value: position

// Example: private _nextPos = [_wounded] call SFSM_fnc_dragPos;

params ["_wounded"];
if!(SFSM_dragWounded)exitWith{};

private _house = [_wounded] call SFSM_fnc_currentBuilding;
private _inDoors = !isNil "_house";
if(_inDoors)exitWith{};

private _objTypes    = ["Tree", "Bush", "ROCK", "ROCKS", "RUIN"];
private _nearObjects = nearestTerrainObjects [_wounded, _objTypes, 4];
if!(_nearObjects isEqualTo [])exitWith{};

private _coverPos = [_wounded, nil, SFSM_maxDragDistance] call SFSM_fnc_getCoverPos;
if(isNil "_coverPos")exitWith{};

private _nearMen = _coverPos nearEntities ['CAManBase', 5];

if(count _nearMen > 2)exitWith{};

_coverPos;