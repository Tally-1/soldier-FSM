{
    private _pos      = _x get "position";
    private _camPos   = (positionCameraToWorld [0,0,0]);
    private _distance = (_camPos distance _pos);
    private _maxDist  = 250;

    if(_x get "active")then{_maxDist = 350;};

    if(_distance < _maxDist)then{[_x] call SFSM_fnc_activationZone3D;};

} forEach SFSM_activationZones;

true;