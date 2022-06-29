private _color = [0.6,0.6,0.1,1];
private _text = "";
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1;
private _maxDistance = 200;
params ["_posArr", "_color", "_text", "_icon", "_size", "_maxDistance"];
{
	[_x, _color, _text, _icon] call SFSM_fnc_drawObjectMarker;
	
} forEach _posArr;