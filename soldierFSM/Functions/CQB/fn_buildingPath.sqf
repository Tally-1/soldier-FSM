private _includeExits = false;
params["_building", "_includeExits", "_startPos"];
private _positions = [_building] call BIS_fnc_buildingPositions;
private _floorPositions = [_positions] call SFSM_fnc_floorPositions;
private _pathPosArr = [];


{_pathPosArr pushBackUnique _x;} forEach (_floorPositions#0);
if(count _floorPositions > 1)
then{{_pathPosArr pushBackUnique _x;} forEach (_floorPositions#1);};

_pathPosArr=([_pathPosArr, [], {_x#2}, "ASCEND"] call BIS_fnc_sortBy);



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