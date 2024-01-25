params[
	["_pos",         nil, [[]]],
	["_radius",      nil,  [0]],
    ["_maxSearchPos", 300,  [0]],
    ["_minSearchPos", 30,   [0]]
];
private _squareSize = _radius*1.5;
private _posCount   = _squareSize;
if(_posCount > _maxSearchPos)then{_posCount = _maxSearchPos;};
if(_posCount < _minSearchPos)then{_posCount = _minSearchPos;};

private _positions =
[
    _pos,                           // Center of square grid 
    _squareSize,                    // Size (a or b) of grid 
    _posCount,                      // How many positions in the grid 
    0,                              // The altitude/z value of the returned positions ([x,y,z])
    {(ATLToASL _x)#2},              // Sorting algorythm (In this case by altitude)
    {_x distance2D _pos < _radius}, // Selection algorythm
    true,                           // Return clear positions only,
    false,                          // Allow positions on water.
    true                            // Allow positions on roads.
] call SFSM_fnc_squareGrid;

if(_positions isEqualTo [])exitwith{};
private _lowest = _positions#0;


_lowest;