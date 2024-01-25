params [ 
    ["_center",          nil, [[],objNull]], 
    ["_size",            nil,          [0]],
    ["_posCount",        100,          [0]],
    ["_zValue",          0,            [0]],
    ["_sortingCode",     nil,         [{}]],
    ["_selectionCode",   nil,         [{}]],
    ["_clearPosOnly",    true,      [true]],
    ["_includeWaterPos", false,    [false]],
    ["_includeRoadpos",  false,     [true]]
];

if(typeName _center isEqualTo "OBJECT")then{_center = getPosATLVisual _center;};

if(_posCount isEqualTo 1)exitWith{[_center]};

if(_posCount isEqualTo 2)exitWith{
    private _posA = [_center, 45, (_size /4), _center#2] call SFSM_fnc_sinCosPos2;
    private _posB = [_center, 225, (_size /4), _center#2] call SFSM_fnc_sinCosPos2;

    [_posA, _posB];
};

private _positions     = [];
private _positions2    = [];
private _axisCount     = round(sqrt _posCount);
private _bottomLeft    = [_center, 225, (_size * 0.7071)] call SFSM_fnc_sinCosPos2;
private _topLeft       = [_center, 315, (_size * 0.7071)] call SFSM_fnc_sinCosPos2;
private _cToCdistance  = _bottomLeft distance2D _topLeft;
private _posDistance   = (_cToCdistance / _axisCount);

private _startPos = _bottomLeft;
private _endPos   = _topLeft;

private _counter = 0;

for "_i" from 1 to _axisCount do {
private _axis = ([_startPos, _endPos, _axisCount, false, _zValue] call Tcore_fnc_straightPosArr);



_positions append _axis;
{_positions2 pushBack _x} forEach _axis;

_startPos = [(_startPos#0 + _posDistance), _startPos#1, _startPos#2];
_endPos   = [(_endPos#0 + _posDistance), _endPos#1, _endPos#2];

_counter = _counter +_axisCount;
};
private _clearPositions = [];

{
    private _noWater    = (_includeWaterPos isEqualTo true)  or {surfaceIsWater _x isEqualTo false};
    private _posIsClear = (_clearPosOnly    isEqualTo false) or {[_x, _includeRoadpos] call Tcore_fnc_positionClear};
    private _valid      = _noWater && {_posIsClear};

    if(_valid)then{_clearPositions pushBack _x;};
    
} forEach _positions;

if(isNil "_sortingCode")exitWith{_clearPositions;};

_clearPositions = [_clearPositions, [], _sortingCode, "ASCEND"] call BIS_fnc_sortBy;

if(isNil "_selectionCode")exitWith{_clearPositions;};

_clearPositions = _clearPositions select _selectionCode;

_clearPositions;