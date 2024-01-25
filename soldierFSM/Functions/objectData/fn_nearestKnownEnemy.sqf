params[ 
	["_man",   nil,            [objNull]],
	["_range", SFSM_overRunDistance, [0]]
];
private _targets = (_man nearTargets _range)apply{_x#4};
if(_targets isEqualTo [])exitWith{objNull;};

private _enemies = _targets select {[_man, _x] call SFSM_fnc_validEnemy;};
if(_enemies isEqualTo [])exitWith{objNull;};

private _nearest = [_man, _enemies] call SFSM_fnc_getNearest;

_nearest;