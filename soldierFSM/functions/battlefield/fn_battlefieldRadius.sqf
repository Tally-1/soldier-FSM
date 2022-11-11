params["_pos", '_baseRadius'];
private _returnRadius = _baseRadius;
private _checkRadius  = _baseRadius*2;
if(_checkRadius < 300)then{_checkRadius = 300};
private _units        = _pos nearEntities ['CAManBase', _checkRadius];
private _filter = {
	([_x] call SFSM_fnc_isRealMan
	&&{(side _x) in [east,west,independent]
	&&{([_x, "currentBattle"] call SFSM_fnc_unitData) == "none"}})
	};

_units = _units select _filter;
private _maxRadius    = [_pos, _units] call Tcore_fnc_clusterSize;

_maxRadius = _maxRadius*1.25;

if(_maxRadius > _baseRadius)then{_returnRadius = _maxRadius};

_returnRadius;