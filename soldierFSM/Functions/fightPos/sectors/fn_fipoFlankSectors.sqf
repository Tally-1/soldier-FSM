params["_fipo"];
private _distance     = _fipo getVariable "flankdistance";
private _offset       = 1;
private _width        = 45;
private _correction   = (_width/2);
private _flankAngle   = 90+_correction;

private _rightSector = 
[
	_fipo,
	_flankAngle,
	_distance,
    _width,
	_offset
] call FIPO_fnc_getObjectSector;

private _leftSector = [
	_fipo,
	0-_flankAngle,
	_distance,
    _width,
	_offset
] call FIPO_fnc_getObjectSector;

[_rightSector, _leftSector];