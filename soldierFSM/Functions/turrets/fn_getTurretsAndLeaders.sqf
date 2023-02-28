params["_vehicles", "_groups"];
private _turrets = _vehicles select {[_x] call SFSM_fnc_isTurret;};
private _leaders = ((_groups apply {leader _x}) select {[_x] call SFSM_fnc_isRealMan;});
[_turrets, _leaders];