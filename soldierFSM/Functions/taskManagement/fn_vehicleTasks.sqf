{
	
	
	if!([_x] call Tcore_fnc_deadCrew)
	then{[_x] call SFSM_fnc_updateVehicle;};
	
} forEach vehicles;