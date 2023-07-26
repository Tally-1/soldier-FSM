params["_fipo"];
if!(_fipo getVariable "hitAndRun")exitWith{0;};
if(time < 60)                     exitWith{0;};

private _timeSinceLast     = round(time - (_fipo getVariable ["SFSM_lastVisit", 0]));
private _remainingCooldown = 60 - _timeSinceLast;

if(_remainingCooldown < 0)        exitWith{0;};

_remainingCooldown;