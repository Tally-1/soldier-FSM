params ["_unitA", "_unitB"];
private _posA      = [([_unitA] call Tcore_fnc_clusterPos)] call Tcore_fnc_roundPos;
private _posB      = [([_unitB] call Tcore_fnc_clusterPos)] call Tcore_fnc_roundPos;
private _radius    = round((_posA distance2D _posB) / 1.8);
private _centerPos = [([_posA, _posB] call Tcore_fnc_getMidpoint)] call Tcore_fnc_roundPos;
        _radius    = [_centerPos, _radius] call SFSM_fnc_battlefieldRadius;
private _units     = (_centerPos nearEntities ["CaManBase", _radius])select{[_x, true, true, true] call SFSM_fnc_canRun;};
private _positions = _units apply {getPosASLVisual _x};
private _center    = [_positions] call Tcore_fnc_avgPos;
private _radius2   = (_center distance2D ([_center, _units] call SFSM_fnc_getFurthest))*1.33;

_radius = selectMax [_radius, _radius2];

[_center, _radius];