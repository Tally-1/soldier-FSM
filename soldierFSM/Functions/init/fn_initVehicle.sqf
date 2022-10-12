params ["_vehicle"];
[_vehicle] call SFSM_fnc_vehicleFiredEh;
if([_vehicle]call Tcore_fnc_deadCrew)exitWith{};

private _vehicleData = createHashMap;
_vehicleData set 	["currentBattle", "none"];
_vehicleData set 	["hiddenPos", []];

_vehicle setVariable ["SFSM_vehicleData", _vehicleData, true];

_vehicleData;