params["_unit", "_muzzle", "_weapon"];

private _action = [_unit, "action"] call SFSM_fnc_unitData;
private _fireActions = ["return fire", "return direct fire"];
if(_action in _fireActions)then{[_unit, _muzzle, _weapon] spawn SFSM_fnc_multiplyRF};
true;