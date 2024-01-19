//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: gets the buildng a man is inside of.

// Params: [_man: object]

// Return value: object || nil

// Example: [player] call SFSM_fnc_currentBuilding


params ["_man"];
private _startPos = eyepos _man;
private _endPos = getPosWorld _man vectorAdd [0, 0, 5];
private _objs = lineIntersectsWith [_startPos, _endPos, _man, objNull, true];
if(_objs isEqualTo [])exitWith{};

private _house = _objs#0;

if(count _objs isEqualTo 1
&& {_house isKindOf "house"})
exitWith{_house};

{
  if(_x isKindOf "house")
  exitWith{_house = _x};
  
} forEach _objs;

if!(_house isKindOf "house")exitWith{};

_house;