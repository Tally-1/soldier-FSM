{
	if  ([_x] call SFSM_fnc_isRealMan)
	then{[_x] call SFSM_fnc_returnToFormation};

} forEach allUnits;

true;