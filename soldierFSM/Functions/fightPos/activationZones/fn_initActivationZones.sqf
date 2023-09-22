params["_zones"];
private _initializedZones = _zones apply {[_x] call SFSM_fnc_initAz;};
private _sorted = [_initializedZones, [], {_x get "mode_code"}, "ASCEND"] call BIS_fnc_sortBy;


_sorted;