params ["_battlefield"];
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _hnkObjects    = missionNamespace getVariable (_battlefield get "hunkerObjects");
private _activeSides   = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
{
	[_x, _battlefield, _hunkerObjData, _hnkObjects] call SFSM_fnc_filterHunkerObjects;
} forEach _activeSides;

true;