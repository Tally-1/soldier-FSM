{
	private _data 		 = _x getVariable "SFSM_UnitData";
	private _notInitialized = isNil "_data";
	private _hasGroup = !([(group _x)] call Tcore_fnc_nilNull);
	
	if(_notInitialized
	&&{_hasGroup})
	then{[_x] call SFSM_fnc_InitMan};
	
	[_x] call SFSM_fnc_HandleSuppression;

} forEach allUnits;