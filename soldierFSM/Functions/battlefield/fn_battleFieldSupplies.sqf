private _ignoreDistance = false;
params["_man", "_battlefield", "_ignoreDistance"];
private _supplies = missionNamespace getVariable (_battlefield get "supplies");
private _deadMen  = missionNamespace getVariable (_battlefield get "deadMen");

_supplies append _deadMen;

_supplies = _supplies select {

	private _isMan       = _x isKindOf "man";
	private _liveMan     = _isMan && {alive _x};
	private _vehicle     = _x isKindOf "land" && {(! _isMan)};
	private _liveVehicle = _vehicle && {!([_x] call Tcore_fnc_deadCrew)};
	private _inDistance  = (_man distance2D _x < 100) || _ignoreDistance;

	_inDistance
	&&{(! _liveMan)
	&&{(! _liveVehicle)}}
};


_supplies;