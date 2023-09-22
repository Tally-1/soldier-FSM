params["_center", "_a", "_b", "_angle", "_isRectangle", "_c"];
_center             = ATLToASL _center;
private _z          = _center#2;
private _cFront     = [_center, _angle, _b, _z]       call SFSM_fnc_sinCosPos2;
private _frontRight = [_cFront, _angle+90, _a, _z]    call SFSM_fnc_sinCosPos2;
private _frontLeft  = [_cFront, _angle-90, _a, _z]    call SFSM_fnc_sinCosPos2;
private _cBack      = [_center, (_angle+180), _b, _z] call SFSM_fnc_sinCosPos2;
private _backRight  = [_cBack, _angle+90, _a, _z]     call SFSM_fnc_sinCosPos2;
private _backLeft   = [_cBack, _angle-90, _a, _z]     call SFSM_fnc_sinCosPos2;

private _positions      = [];
private _floorPositions = [_frontRight, _frontLeft, _backLeft, _backRight] apply {ASLToATL _x};
private _roofPositions  = _floorPositions apply {[_x, _c] call Tcore_fnc_addZ;};

_positions append _floorPositions;
_positions append _roofPositions;

_floorPositions =
_floorPositions apply {
	_x params ["_xx", "_y", "_z"];
	// if(_z < 0.2)then{_z = 0.2};
	[_xx, _y, 0.2];
};

[_floorPositions, _roofPositions, _positions];