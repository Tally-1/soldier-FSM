params ["_vehicle"];
[_vehicle] call SFSM_fnc_vehicleFiredEh;
[_vehicle] call SFSM_fnc_vehicleActions;

private _allowHijack = _vehicle getVariable "SFSM_allowHijack";

if(isNil "_allowHijack")then{
	_vehicle setVariable ["SFSM_allowHijack", true, true];
};


if([_vehicle]call Tcore_fnc_deadCrew)exitWith{};

private _vehicleData = createHashMap;
_vehicleData set 	["currentBattle", "none"];
_vehicleData set 	["hiddenPos", []];

_vehicle setVariable ["SFSM_vehicleData", _vehicleData, true];

_vehicleData;