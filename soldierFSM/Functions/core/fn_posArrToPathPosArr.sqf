params ["_posArr"];
private _end = _posArr#(count _posArr-1);
private _pos = _posArr#0;
private _newArr = [];

private _getNearestXprevious = { 
    //gets the nearest position relative to the current position that has not already been selected.
    params ["_pos", "_posArr", "_previousPositions"];
    private _eligble = _posArr select {!(_x in _previousPositions)};
    private _sortedArr = ([_eligble, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy);
    private _nextPos = _sortedArr#0;

    _nextPos;
};

{
    private _newPos = [_pos, _posArr, _newArr] call _getNearestXprevious;
    if(_newPos isEqualTo _end)
    exitWith{_newArr pushBackUnique _newPos;};//start && end positions are inserted before calling this function, 
    _newArr pushBackUnique _newPos;           //hence the last pos in the original array is also the last position of the
    _pos = _newPos;                           //path.
} forEach _posArr;

_newArr;