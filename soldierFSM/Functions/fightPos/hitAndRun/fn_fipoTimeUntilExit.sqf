params ["_fipo"];
if!(_fipo getVariable "hitAndRun")exitWith{-1;};

private _timeLimit = _fipo getVariable "hitandruntimeout";
private _getInTime = _fipo getVariable "getInTime";

if(isNil "_getInTime")exitWith{-1;};

private _timeSpent     = round (time - _getInTime);
private _timeLeft      = _timeLimit  - _timeSpent;

if(_timeLeft < 0)then{_timeLeft = 0;};

_timeLeft;