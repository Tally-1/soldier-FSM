params["_group", "_forceLeave"];

{
	if([_x] call SFSM_fnc_isRealMan
	&&{[_x, "action"] call SFSM_fnc_unitData isEqualTo "Manning turret!"})then{

       [_x, _forceLeave] call SFSM_fnc_turretGetOut;
	};
	
} forEach (units _group);

true;