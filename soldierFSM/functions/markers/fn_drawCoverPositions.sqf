params ["_posArr", "_color"]; 
private _markers = [];

{
	private _marker = [_x, "", 0.4, _color, "mil_end_noShadow"] call SFSM_fnc_posMarker;
	_markers pushBackUnique _marker;
} forEach _posArr;

_markers;