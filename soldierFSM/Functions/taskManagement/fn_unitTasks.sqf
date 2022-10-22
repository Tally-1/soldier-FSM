{
	if([_x] call SFSM_fnc_isRealMan)
	then{
		private _data 		    = _x getVariable "SFSM_UnitData";
		private _notInitialized = isNil "_data";
		
		if(_notInitialized)
		then{[_x] call SFSM_fnc_InitMan}
		else{[_x] call SFSM_fnc_HandleSuppression;};
		
		
};
} forEach allUnits;