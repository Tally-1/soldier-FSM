private _defaultPos = getPosATLVisual (_this#0);
params[
    ["_man",    nil,    [objNull]], 
    ["_radius", nil,          [0]], 
    ["_pos",    _defaultPos, [[]]]
];
private _entities = _pos nearEntities _radius;
if(_entities isEqualTo [])exitWith{[]};

private _side       = side group _man;
private _friendlies = _entities select {[_x, _side]call SFSM_fnc_manIsAvailFriendly};

_friendlies;