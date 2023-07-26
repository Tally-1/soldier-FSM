//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_building"];
private _positions = _building buildingPos -1;
private _floorPositions = [_positions] call SFSM_fnc_floorPositions;
private _nearest = ([_positions, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
if(isNil "_nearest")then{_nearest = (getPos _man)};
if(count _floorPositions == 1)exitWith{_nearest};

private _manPos = getPos _man;
private _floorInUse = 0;
private _avgHeight = [_positions] call Tcore_fnc_avgHeight;

if(_manPos#2>_avgHeight)then{_floorInUse = 1;};

private _newPositions = _floorPositions#_floorInUse;
private _newNearest = ([_newPositions, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

if(isNil "_newNearest")exitWith{_nearest};

_newNearest;