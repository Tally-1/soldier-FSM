{
    private _data     = _x getVariable "SFSM_vzData";
	private _pos      = _data get "position";
    private _camPos   = (positionCameraToWorld [0,0,0]);
    private _distance = (_camPos distance _pos);
    private _maxDist  = 250;

    if(_data get "active")   then{_maxDist = 350};
	if(_distance < _maxDist) then{[_data] call SFSM_fnc_VZ3D};

} forEach (entities "SFSM_VZ");

true;