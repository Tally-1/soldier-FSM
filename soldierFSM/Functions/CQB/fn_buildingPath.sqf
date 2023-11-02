//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Returns an array of positions that can be used to create a path for AI to follow.

// Params: [_building:object, _includeExits:boolean, _startPos[number, number, number]]

// Return value: array of positions

// Example: [_building, true, (getPos player)] call SFSM_fnc_buildingPath;

private _includeExits = false;
params["_building", "_includeExits", "_startPos"];
private _positions = _building buildingPos -1;
if(isNil "_positions")      exitwith {[];};
if(_positions isEqualTo []) exitwith {[];};

private _floorPositions = [_positions] call SFSM_fnc_floorPositions;
private _pathPosArr = [];


{_pathPosArr pushBackUnique _x;} forEach (_floorPositions#0);
if(count _floorPositions > 1)
then{{_pathPosArr pushBackUnique _x;} forEach (_floorPositions#1);};

_pathPosArr=([_pathPosArr, [], {(AGLToASL _x)#2}, "ASCEND"] call BIS_fnc_sortBy);



if(_includeExits)
then{
    private _exits = [_building] call SFSM_fnc_buildingExits;
    if(_exits isEqualTo [])exitWith{};
    if(!isNil "_startPos")
    then{_exits = ([_exits, [], {_startPos distance _x }, "ASCEND"] call BIS_fnc_sortBy);};
    
    _pathPosArr insert [0, [(_exits#0)], false];
    _pathPosArr pushBackUnique (_exits#(count _exits -1));
};


// _pathPosArr = [_pathPosArr] call Tcore_fnc_posArrToPathPosArr;

_pathPosArr;