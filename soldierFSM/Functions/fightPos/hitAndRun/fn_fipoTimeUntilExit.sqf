params ["_fipo"];
if!(_fipo getVariable "hitAndRun")exitWith{-1;};

private _firstShot = _fipo getVariable "SFSM_firstShot";
if(isNil "_firstShot")exitWith{-1;};

private _timeSinceShot = round (time - _firstShot);
private _timeUntilExit = 60 - _timeSinceShot;

if(_timeUntilExit < 0)then{_timeUntilExit = 0;};

_timeUntilExit;