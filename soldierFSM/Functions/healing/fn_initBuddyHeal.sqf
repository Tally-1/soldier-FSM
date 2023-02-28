params["_healer", "_wounded", "_incapacitated"/*, "_allHealers"*/];
_incapacitated = _incapacitated select {[_healer, _x] call SFSM_fnc_canBuddyHeal;};
_wounded       = _wounded       select {[_healer, _x] call SFSM_fnc_canBuddyHeal;};

if(count _incapacitated > 0)exitWith{
	private _toBeRevived = [_healer, _incapacitated] call SFSM_fnc_getNearestOrPlayer;
	// private _reviver     = [_allHealers, _toBeRevived] call SFSM_fnc_nearestHealer;

	[_healer, _toBeRevived] spawn SFSM_fnc_buddyRevive;
	true;
};

if(count _wounded > 0)exitWith{
	private _toBeHealed = [_healer, _wounded] call SFSM_fnc_getNearestOrPlayer;
	[_healer, _toBeHealed] spawn SFSM_fnc_buddyHeal;
	true;
};

false;