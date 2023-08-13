params[
    "_man", 
    ["_radius",    SFSM_overRunDistance], 
    ["_pos",       nil], 
    ["_knownOnly", false],
    ["_excluded",  []]
];

if(isNil "_pos")then{_pos = getPos _man};

private _entities = _pos nearEntities _radius;
if(_entities isEqualTo [])exitWith{[]};

private _enemies = (_entities select {
    private _known = _knownOnly isEqualTo false || {_man knowsAbout _x > 3};
    private _valid = [_man, _x] call SFSM_fnc_validAlly;
    
    _valid
    &&{_known
    &&{_x isNotEqualTo _man
    &&{(_x in _excluded) isEqualTo false
    }}}
});

_enemies;