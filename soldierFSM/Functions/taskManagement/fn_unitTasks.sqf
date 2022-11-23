{
	if([_x] call SFSM_fnc_isRealMan)
	then{
		private _data = _x getVariable "SFSM_UnitData";
				
		if(isNil "_data")
		then{[_x] call SFSM_fnc_InitMan}
		else{[_x] call SFSM_fnc_HandleSuppression;};

		if!(SFSM_globalUD)then{
		_x setVariable["SFSM_UnitData", _data, true];};
		
		
};
} forEach allUnits;