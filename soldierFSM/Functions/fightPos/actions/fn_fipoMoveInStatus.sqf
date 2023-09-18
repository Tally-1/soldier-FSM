params["_man", "_leader", "_fipo", "_startTime", "_startPos"];
private _status = "in progress";

if([_man, _fipo] call SFSM_fnc_canTeleportFipo)then{
    [_man] call SFSM_fnc_abortForcedMove;
    _status = "teleport";
};


if (_leader distance2D _fipo > SFSM_fipoGetInDistance
&& {time - _startTime > 20
&& {_startPos distance2D _man < 5
&& {_man distance2D _fipo > 10
&& {speed _man < 1
}}}})
exitWith{
    [_man] call SFSM_fnc_abortForcedMove;
    _status = "abort";
};

_status;