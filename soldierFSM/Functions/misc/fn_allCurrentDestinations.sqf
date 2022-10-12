private _destinations = [];

{
	if([_x] call SFSM_fnc_isRealMan)
	then{
		  private _destination = [_x, "currentDestination"] call SFSM_fnc_unitData;
		  if((!isNil '_destination')
		  &&{!(_destination isEqualTo [0,0,0])})
		  then{_destinations pushBackUnique _destination;};
	}
	
} forEach allUnits;
_destinations;