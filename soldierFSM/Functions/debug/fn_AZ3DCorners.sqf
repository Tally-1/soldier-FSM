params[
	"_AZ", 
	["_color", [1,1,1,0.8]]
];

private _pos         = _AZ get "position";
private _screenPos   = worldToScreen _pos;
if(_screenPos isEqualTo [])    exitWith{false;};
if((selectMax _screenPos) > 2) exitWith{false;};


private _camPos      = (positionCameraToWorld [0,0,0]);
private _distance    = (_camPos distance2d _pos);
private _maxDist     = (_AZ get "radius");
if(_distance > _maxDist)exitWith{false;};

(_AZ get "corners")params["_floor", "_roof", "_all"];
private _j = 0;
private _lines = (_floor apply {
	private _endPos = _roof#_j; _j= _j+1;
	[_x, _endPos, _color];
});

_lines append [
	[_roof#0, _roof#1, _color],
	[_roof#2, _roof#3, _color],
	[_roof#0, _roof#3, _color],
	[_roof#1, _roof#2, _color]
];

{drawLine3D _x;} forEach _lines;

_lines;