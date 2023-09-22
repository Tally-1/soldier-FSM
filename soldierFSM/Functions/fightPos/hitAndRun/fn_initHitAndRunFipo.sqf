params["_man", "_fipo"];

private _timeOut = _fipo getVariable "hitandruntimeout";
private _random  = _fipo getVariable "hrTimeoutRandom";

_timeOut = [_timeOut, _random]call SFSM_fnc_addRandomToValue;


_fipo setVariable ["shotsFired", 0];
_fipo setVariable ["getInTime",  time];
_fipo setVariable ["timeLimit",  ceil _timeOut];

[_man] call SFSM_fnc_firedHitAndRunEH;

true;