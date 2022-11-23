private _posCount = 100;
private _zValue = 0;
private _includeWaterPos = false;
params [
	"_Center", 
	"_Size", 
	"_posCount",
	"_zValue",
	"_includeWaterPos"
	];

private _bottomLeft    = [_center#0, _center#1, 225, (_Size * 0.7071)] call Tcore_fnc_sinCosPos;
private _topLeft       = [_center#0, _center#1, 315, (_Size * 0.7071)] call Tcore_fnc_sinCosPos;
private _cToCdistance  = _bottomLeft distance2D _topLeft;

private _positions   = [];
private _axisCount   = round(_posCount / 10);
private _posDistance = (_cToCdistance / _axisCount);

private _yAxis = [_bottomLeft, _topLeft, (_axisCount-2)] call Tcore_fnc_straightPosArr;

{
	private _westPos = _x;
	private _eastPos = [_westPos#0, _westPos#1, 90, _cToCdistance] call Tcore_fnc_sinCosPos;
	private _newPositions = [_westPos, _eastPos, (_axisCount-2), true, _zValue] call Tcore_fnc_straightPosArr;
	_positions append _newPositions;
} forEach _yAxis;

_positions = _positions select {(_includeWaterPos || (!surfaceIsWater _X))};

_positions;