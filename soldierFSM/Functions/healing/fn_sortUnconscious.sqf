params["_incapacitated"];
_incapacitated = [
	_incapacitated, 
	[], 
	{ 
		private _value = 0.1;
		if([_x] call SFSM_fnc_isPlayer)        then{_value = 1;};
		if([_x] call SFSM_fnc_isMedic)         then{_value = 0.8;};
		if([_x] call SFSM_fnc_isMarksman)      then{_value = 0.6;};
		if([_x] call SFSM_fnc_isATSoldier)     then{_value = 0.4;};
		if([_x] call SFSM_fnc_isMachineGunner) then{_value = 0.2;};
		
		_value;
	}, 
	"DESCEND"
	
	] call BIS_fnc_sortBy;

_incapacitated;