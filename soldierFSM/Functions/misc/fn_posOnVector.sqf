params[
	["_startPos", nil, [[]]], // start of original vector 
	["_endPos",   nil, [[]]], // end of original vector 
	["_distToPos", nil, [0]]  // how far into the vector you wish to retrieve a position 
];
private _dir      = _startPos getDir _endPos;
Private _distance = (_startPos distance2d _endPos);
private _distCoef = _distance / _distToPos;

private _origX    = _startPos#0;
private _origY    = _startPos#1;
private _origZ    = _startPos#2;
private _endZ     = _endPos#2;

private _elevationDiff    = [_origZ, _endZ]  call SFSM_fnc_numberDiff;
private _elevationBetween = _elevationDiff / _distCoef;
private _xx	              = ((sin _dir) * _distToPos) + _origX;
private _yy	              = ((cos _dir) * _distToPos) + _origY;
private _zz	              = _origZ + _elevationBetween;


[_xx, _yy, _zz];