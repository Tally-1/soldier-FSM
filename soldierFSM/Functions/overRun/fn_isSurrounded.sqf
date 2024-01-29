params[
	["_man", nil, [objNull]]
];
private _pos        = getPosATLVisual _man;
private _nearMen    = _pos nearEntities ["CAManBase", SFSM_overrunDistance];
private _enemies    = count(_nearMen select {[_man, _x] call SFSM_fnc_validEnemy;});
private _friends    = count(_nearMen select {[_man, _x] call SFSM_fnc_validAlly;});
private _surrounded = _enemies > _friends;

_surrounded;