private _camPos    = (positionCameraToWorld [0,0,0]);
// private _positions = SFSM_allFipos select {_camPos distance2D _x < 200};

{

    ([_x] call SFSM_fnc_fipoDebugData)
	params [
		"_pos",
        "_color",
        "_text",
        "_icon",
        "_size"
	];
    
	[
        _pos,
        _color,
        _text,
        _icon,
        _size,
        200
    ] call SFSM_fnc_drawObjectMarker;

} forEach SFSM_allFipos;