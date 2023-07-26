// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

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