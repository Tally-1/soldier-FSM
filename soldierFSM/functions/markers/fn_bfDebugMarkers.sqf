params ["_battleField"];
if!(SFSM_Debugger)exitWith{};

private _markers   = [];
private _centerPos = (_battleField get "center");
private _radius    = (_battleField get "radius");
private _areaName  = (_battleField get "name");
private _zones     = (_battleField get "zones");

private _coverPos  = (_battleField get "coverPositions");

private _marker1 = [_centerPos, _radius] call SFSM_fnc_drawCircle;
private _marker2 = [_centerPos, _areaName, 1] call SFSM_fnc_posMarker;
{_markers pushback _x}forEach[_marker1, _marker2];



{
  	private _cMarker = [_x] call Tcore_fnc_ClusterMarker;
	_markers pushback _cMarker;
}forEach _clustersData;



{
	private _color = ["Color",_x] joinString "";
	private _pos   = _y#0;
	private _Radius= _y#1;

	if(count _pos > 2)
	then{
			private _zMarker = [_pos, _Radius, nil, _color] call SFSM_fnc_drawCircle;
			_markers pushBack _zMarker;
		};

} forEach _zones;

if(isNil "_coverPos")    exitWith{_battleField set ["markers", _markers]; _markers};
if(count _coverPos > 100)exitWith{_battleField set ["markers", _markers]; _markers};

{
	private _color = ["Color",_x] joinString "";
	private _newMarkers = [_Y, _color] call SFSM_fnc_drawCoverPositions;
	_markers append _newMarkers;
} forEach _coverPos;




_battleField set ["markers", _markers];

_markers;