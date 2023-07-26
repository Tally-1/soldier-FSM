params["_trajectory"];

private _camPos   = (positionCameraToWorld [0,0,0]);
private _start    = _trajectory#0#0;
private _distance = _camPos distance2D _start;

if(_distance > 2000)exitWith{};

{
    private _start = _x#0;
    private _end   = _x#1;
    drawLine3D [_start, _end, [0,1,0,1]];
    
} forEach _trajectory;