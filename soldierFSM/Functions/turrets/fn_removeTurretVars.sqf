params ["_turret", "_man"];

private _assignedGunner = (_turret getVariable ["SFSM_gunner", objNull])==_man;
if(_assignedGunner)then{
	[_man, "action", "none"]   call SFSM_fnc_unitData;
};

private _eh = _turret getVariable "SFSM_getOutEH";
if(!isNil "_eh")then{
_turret removeEventHandler ["GetOut", _eh];
};

_turret setVariable        ["SFSM_gunner", nil];
_turret setVariable        ["SFSM_getOutEH", nil];

unassignVehicle _man;