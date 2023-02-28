private _includeMedics = false;
params["_group", "_includeMedics"];
private _regulars = (units _group) select {

	private _soldierType = [_x] call SFSM_fnc_squadAsset;
	
	((_soldierType isEqualTo "regular"
	||(_includeMedics                  && 
	{_soldierType isEqualTo "medic"})) &&
	{[_x] call SFSM_fnc_isRealMan      && 
	{[_x, true] call SFSM_fnc_canDodge
	}});

};

_regulars;