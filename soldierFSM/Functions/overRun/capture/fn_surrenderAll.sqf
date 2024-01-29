{
	if([_x] call SFSM_fnc_canPanicSurrender
	||{[_x] call SFSM_fnc_manInLoosingState})then{
		[_x] spawn SFSM_fnc_surrender;
	};
	
} forEach entities "CAManBase";