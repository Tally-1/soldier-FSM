params[ 
	["_man",             nil,            [objNull]],
	["_searchRadius",    SFSM_overRunDistance, [0]],
	["_defaultDistance", 10000,                [0]]
];
private _nearestEnemy = [_man, _searchRadius] call SFSM_fnc_nearestKnownEnemy;
if(isNull _nearestEnemy)exitWith{_defaultDistance;};

private _distance = _man distance _nearestEnemy;

_distance;