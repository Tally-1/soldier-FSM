private _defaultPos = getPosATLVisual (_this#0);
params[
    ["_man",       nil,            [objNull]],
    ["_radius",    SFSM_overRunDistance, [0]], 
    ["_pos",       _defaultPos,         [[]]], 
    ["_knownOnly", false,             [true]],
    ["_excluded",  [],                  [[]]]
];

private _entities = _pos nearEntities _radius;
if(_entities isEqualTo [])exitWith{[]};

private _enemies = (_entities select {
	private _known = _knownOnly isEqualTo false || {_man knowsAbout _x > 3};
	
	(_known                                   // Known 
	&&{(_x in _excluded) isEqualTo false      // Not Excluded
	&&{[_man, _x] call SFSM_fnc_validEnemy}}) // Valid 
});

_enemies;