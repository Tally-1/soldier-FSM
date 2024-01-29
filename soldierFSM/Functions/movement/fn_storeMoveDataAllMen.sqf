{
	if([_x, true] call SFSM_fnc_canRun)
	then{[_x] call SFSM_fnc_storeMoveData}

} forEach (entities "CAManBase");

true;