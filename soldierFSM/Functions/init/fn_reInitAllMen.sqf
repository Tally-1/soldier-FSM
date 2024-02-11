{
	if([_x,true] call SFSM_fnc_isRealMan)
	then{[_x] call SFSM_fnc_initMan;};
	
} forEach allUnits;

true;