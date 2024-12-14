params [
    ['_man', nil,[objNull]],
    ["_rad", nil,      [0]]
];
private _enemies = _man nearEntities ["caManBase", _rad]select{
    private _hostile = [_man, _x]call SFSM_fnc_validEnemy;
    private _known   = _man knowsAbout _x > 3.5;
    private _valid   = _hostile &&{_known};
    _valid;
};

if(_enemies isEqualTo [])exitWith{[]};

_enemies = [_man, _enemies] call Tcore_fnc_sortByDist;

_enemies;