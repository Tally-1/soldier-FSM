params["_unitA", "_unitB"];
private _posA          = (getPos _unitA);
private _posB          = (getPos _unitB);
private _midPos        = [_posA, _posB] call Tcore_fnc_getMidpoint;
private _nearestBattle = [_midPos] call SFSM_fnc_nearestBattle;

if!(typeName _nearestBattle == "HASHMAP")
exitWith{["start", ""]};

private _battlePos    = _nearestBattle     get "center";
private _battleKey    = str(_nearestBattle get "center");
private _battleRadius = _nearestBattle     get "radius";
private _distanceA    = _posA distance2D _battlePos;
private _distanceB    = _posB distance2D _battlePos;



private _insideBattle = (_distanceA < _battleRadius
					  &&{_distanceB < _battleRadius});

if(_insideBattle)exitWith{["join", _battleKey]};

private _distToBattle    = _midPos distance2D _battlePos;
private _AtoB            = (_posA distance2D _posB);
private _thisRadius      = (_AtoB / 2);
private _combinedRadius  = _battleRadius + _thisRadius;

private _maxDistance     = round(selectMax[_distToBattle, _distanceA, _distanceB]);
private _expand          = (_combinedRadius > _distToBattle);

private _addedRadius     = (_maxDistance - _battleRadius);

if(_expand)exitWith{["expand", _battleKey, _addedRadius]};

["start", ""];