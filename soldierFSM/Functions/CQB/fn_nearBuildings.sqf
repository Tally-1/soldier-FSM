params[ 
	["_pos", nil,    [[]]],
	["_rad", nil,     [0]],
    ["_sort",false,[true]],
    ["_ownMen",[],   [[]]]
];
private _buildings = _pos nearObjects ["House", _rad] select {[_x, true, 2] call SFSM_fnc_isHouse};

_buildings;