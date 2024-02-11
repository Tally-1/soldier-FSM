params[
    ["_captive",      nil, [objNull]],
    ["_timeCaptured", nil,       [0]]
];
private _timeSinceCapture = round(time-_timeCaptured);
private _deathTimeLimit   = SFSM_captiveAutoDeath*60;
private _isTimeOfDeath    = _timeSinceCapture >= _deathTimeLimit;
private _timeLimitInUse   = SFSM_captiveAutoDeath > 0;

if(_timeLimitInUse
&&{_isTimeOfDeath isEqualTo true;})
exitWith{true;};

if(_timeLimitInUse
&&{_isTimeOfDeath isEqualTo false;})
exitWith{false;};

private _nearSoldiers = (_captive nearEntities [["caManBase"],100])select{[_x] call SFSM_fnc_functionalMan &&{(_x getVariable ["SFSM_captive", false])isEqualTo false;}};
private _isLonely     = _nearSoldiers isEqualTo [];

_isLonely;