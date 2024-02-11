params[
	["_captive",      nil, [objNull]],
	["_timeCaptured", nil,       [0]]
];
private _killNow = _this call SFSM_fnc_canAutoKillCaptive;
if!(_killNow)exitWith{false;};

_captive setDamage 1;

true;