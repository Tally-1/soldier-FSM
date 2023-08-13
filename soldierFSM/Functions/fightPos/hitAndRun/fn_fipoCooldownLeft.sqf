params["_fipo"];
if!(_fipo getVariable "hitAndRun")exitWith{0;};

private _coolDown          = round(_fipo getVariable "hitAndRunCooldown");
private _timeSinceLast     = round(time - (_fipo getVariable ["SFSM_lastVisit", -300]));
private _remainingCooldown = _coolDown - _timeSinceLast;

if(_remainingCooldown < 0)        exitWith{0;};

_remainingCooldown;