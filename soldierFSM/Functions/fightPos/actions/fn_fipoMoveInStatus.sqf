params["_man", "_leader", "_fipo", "_startTime", "_startPos"];

if (_leader distance2D _fipo > SFSM_fipoGetInDistance
|| {time - _startTime > 20
&& {_startPos distance2D _man < 10
&& {_man distance2D _fipo > 10
&& {speed _man < 3
}}}})
exitWith{
    [_man] call SFSM_fnc_abortForcedMove;
    "abort";
};

if([_man, _fipo] call SFSM_fnc_canTeleportFipo)then{
    [_man] call SFSM_fnc_abortForcedMove;
    "teleport";
};

"in progress";