params[
		"_man", 
		"_building",
		"_buildingVarName"
	];


[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
_building setVariable ["SFSM_explosiveRigged", true];
missionNamespace setVariable [_buildingVarName, _building];
_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";