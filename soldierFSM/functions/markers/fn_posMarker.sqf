// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _type = "hd_dot";
private _text = "";
private _color= "ColorBlack";
private _size = 1;
params["_position", "_text", "_size", "_color", "_type"];

if(isNil "SFSM_debugMarkers")then{SFSM_debugMarkers = []};
private _markerCount = count SFSM_debugMarkers;
private _markerName  = [(round((random 1) * 100000)), "_posMarker_", _markerCount] joinString "";

private _marker = createMarkerLocal [_markerName, _position];

_markerName setMarkerTypeLocal _type;
_markerName setMarkerSizeLocal  [_size, _size];
_markerName setMarkerColorLocal _color;
_markerName setMarkerTextLocal _text;
_markerName setMarkerAlpha 1;

SFSM_debugMarkers pushBackUnique _markerName;

_markerName