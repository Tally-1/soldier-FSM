params[ 
    ["_pos",  nil,     [[]]],
    ["_rad",  nil,      [0]],
    ["_sort", false, [true]]
];
private _buildings       = [_pos, _rad] call SFSM_fnc_nearBuildings;
private _positions       = [];
private _customPositions = _pos nearObjects ["CBA_BuildingPos", _rad]apply{getPosATLVisual _x};

_positions insert [0, _customPositions, true];
{_positions insert [0,(_x buildingPos-1),true]}forEach _buildings;

if(_sort)then{
    _positions = [_positions, [], {_pos distance2D _x}, "ASCEND"] call BIS_fnc_sortBy;
};

_positions;