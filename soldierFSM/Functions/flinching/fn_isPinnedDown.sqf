params ["_man"];
private _flinchTimes = [_man, "flinchTimes"] call SFSM_fnc_unitData;
private _lastPinDown = [_man, "lastPinDown"] call SFSM_fnc_unitData;

private _nearFlinches = _flinchTimes select {
    private _time = _x#0;
    private _pos  = _x#1;
    private _timePassed = time - _time;
    _pos distance2d _man < 10 
    &&{_timePassed >= 10}
};

if(count _nearFlinches > 2
&&{time - _lastPinDown > 10})exitWith{
    [_man, "lastPinDown", time] call SFSM_fnc_unitData;
    true;
};

false;