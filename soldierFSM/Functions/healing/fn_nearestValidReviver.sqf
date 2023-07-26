params["_unconMan", "_healers", "_excluded"];
_healers = _healers select {
	[_x, _unconMan] call SFSM_fnc_canBuddyHeal && 
	{!(_x in _excluded)}
};

if(_healers isEqualTo [])exitWith{};
private _nearest = [_x, _healers] call SFSM_fnc_getNearest;

_nearest;