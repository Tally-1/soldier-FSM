params ["_turret", "_role", "_man"];

private _myVehicle = _man getVariable "SFSM_myVehicle";//set in the proneHeal function
if(isNil "_myVehicle")exitWith{
	[_turret, _man]call SFSM_fnc_removeTurretVars;
};

sleep 6;

if([_turret] call Tcore_fnc_deadCrew)then{
	[_turret, _man]call SFSM_fnc_removeTurretVars;
};