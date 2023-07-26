private _radius = SFSM_overRunDistance;
private _knownOnly = false;
params["_man", "_radius", "_pos", "_knownOnly"];
if(isNil "_pos")then{_pos = getPos _man};

private _enemies = ((_pos nearEntities _radius) select {
	[_man, _x] call SFSM_fnc_validEnemy
	&&{(! _knownOnly) || {_man knowsAbout _x > 3}}
});
_enemies;