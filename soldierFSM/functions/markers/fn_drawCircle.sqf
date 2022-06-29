private _color = "ColorBlack";
private _brush = "BORDER";
params["_pos", "_radius", "_brush", "_color"];

private _markerName  = [(round((random 1) * 100000)), "_randomCircle"] joinString "";
private _marker = createMarker [_markerName, _pos];

_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerBrush _brush;
_markerName setMarkerSize  [_radius, _radius];
_markerName setMarkerColor _color;
_markerName setMarkerAlpha 1;


_markerName