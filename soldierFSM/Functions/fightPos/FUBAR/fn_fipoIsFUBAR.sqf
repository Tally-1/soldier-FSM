params["_fipo"];
if(_fipo getVariable ["destroyed", false])exitWith{true;};

private _tSinceKnock = [_fipo] call SFSM_fnc_timeSinceFipoKnockOut;
if(_tSinceKnock < SFSM_fipoKnockOutTime)exitWith{true;};

false;