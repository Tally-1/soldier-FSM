params["_pos", "_radius", "_searchCount"];
private _positions = [_pos, _radius, _searchCount] call Tcore_fnc_squareGrid select {[_x] call Tcore_fnc_positionClear};

_positions;
