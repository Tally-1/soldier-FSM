params ["_dataArr"];
private _pos          = _dataArr # 0;
private _radius      = _dataArr # 2;
private _side          = _dataArr # 3;
private _color         = "ColorOrange";//[0.85,0.4,0,1];
if(isNil "Tcore_debugMarkers")then{Tcore_debugMarkers = []};
private _markerCount = count Tcore_debugMarkers;
private _markerName  = [(round((random 1) * 100000)), "_clusterMarker_", _markerCount] joinString "";


switch (_side) do {
                    case east:        {_color = "ColorEAST"/*[0,0.3,0.6,1]*/};
                    case west:        {_color = "ColorWEST"/*[0,0.3,0.6,1]*/};
                    case independent: {_color = "ColorGUER"/*[0,0.3,0.6,1]*/};
                   };
private _marker = createMarker [_markerName, _pos];

_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerSize  [_radius, _radius];
_markerName setMarkerColor _color;
_markerName setMarkerAlpha 1;

_markerName