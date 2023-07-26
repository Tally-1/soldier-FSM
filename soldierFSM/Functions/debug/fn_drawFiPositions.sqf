private _camPos   = (positionCameraToWorld [0,0,0]);
private _positions = SFSM_fiPositions select {_camPos distance2D _x < 200};

{
    private _pos     = getPosATLVisual _x;
    private _color   = [0,1,0.9,0.3];
    private _text    = "Fighting Position";
    private _icon    = "\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa";
    private _size    = 1.5;
    private _name    = _x getVariable "posname";

    if(_name isNotEqualTo "")then{
        _text = _name;
    };

    if(_x getVariable "hitAndRun")then{
	    private _cooldown = [_x] call SFSM_fnc_fipoCooldownLeft;
        _color = [0,1,0.9,0.5];
        _text  = "Hit And Run position.";

        if(_cooldown > 0)then{
            _text  = [
                "Hit And Run cooldown, ",
                _cooldown,
                " seconds left"

            ]joinString"";
        };

        private _timeUntilExit = [_x] call SFSM_fnc_fipoTimeUntilExit;
        if(_timeUntilExit isNotEqualTo -1)then{
            _text  = [
                "Hit And Run, Exit in ",
                _timeUntilExit,
                " seconds"

            ]joinString"";
        };

    };


    if((synchronizedObjects _x) isNotEqualTo [])then{
        private _man = [_x] call SFSM_fnc_fipoMan; 
        _color = [(side _man)] call SFSM_fnc_sideColor;
    };

    [
        _pos,
        _color,
        _text,
        _icon,
        _size
    ] call SFSM_fnc_drawObjectMarker;

} forEach _positions;