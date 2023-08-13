params["_fipo"];
private _time          = (round time);
private _defaultValue  = _time - (SFSM_fipoKnockOutTime+1);
private _lastKnockOut  = _fipo getVariable ["lastKnockout", _defaultValue];
private _timeSinceKnck = _time - _lastKnockOut;

_timeSinceKnck;