if!(_self get "activatedByBattle")exitWith{false;};

private _area       = _self get "area";
private _zoneCenter = _area#0;
private _battle     = [_zoneCenter] call SFSM_fnc_nearestBattle;

if(typeName _battle isNotEqualTo "HASHMAP")exitWith{false;};

private _battlePos    = _battle get "center";
private _battleRadius = (_battle get "radius")*0.9;
private _distToBattle = _battlePos distance2D _zoneCenter;

if(_distToBattle < _battleRadius)exitWith{true;};

private _distance     = selectMin [_battleRadius, _distToBattle];
private _dirToZone    = _battlePos getDir _zoneCenter;
private _nearZonePos  = [_battlePos, _dirToZone, _battleRadius] call SFSM_fnc_sinCosPos2;

if(_nearZonePos inArea _area)exitWith{true;};

false;