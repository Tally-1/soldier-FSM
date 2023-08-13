
addMissionEventHandler ["BuildingChanged", {
	params ["_from", "_to", "_isRuin"];
	_this spawn SFSM_fnc_fipoBuildingDestroyed;
	
	
}];