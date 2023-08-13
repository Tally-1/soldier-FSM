params["_fipo"];
private _offset       = 1;
private _distR        = _fipo getVariable "rightFlank";
private _distL        = _fipo getVariable "leftFlank";
private _widthR       = 180*(_fipo getVariable "sfsm_rightflankwidth");
private _widthL       = 180*(_fipo getVariable "sfsm_leftflankwidth");
private _correctionR  = (_widthR/2);
private _correctionL  = (_widthL/2);
private _angleR       = 0-(180+_correctionR);
private _angleL       = 180+_correctionL;

private _rightSector = [
	_fipo,
	_angleR,
	_distR,
    _widthR,
	_offset
] call FIPO_fnc_getObjectSector;

private _leftSector = [
	_fipo,
	_angleL,
	_distL,
    _widthL,
	_offset
] call FIPO_fnc_getObjectSector;

[_rightSector, _leftSector];