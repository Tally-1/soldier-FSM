params["_man", "_battlefield"];
private _weapons = missionNamespace getVariable (_battlefield get "weapons");
private _machineguns =
_weapons select {

	private _inDistance  = _man distance2D _x <= SFSM_DodgeDistance;
	private _weaponType  = getWeaponCargo _x#0#0;
	private _classId     = ([_weaponType] call objScan_fnc_weaponData) get "class ID";
	private _machinegun  = ((_classId > 2.5 && {_classId < 4})
						or(_classId >= 1.7 && {_classId <= 1.8}));

	_inDistance
	&&{_machinegun};
};

_machineguns;