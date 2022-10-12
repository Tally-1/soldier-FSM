/*
Retrieves or stores data from the SFSM_vehicleData hashmap.
_vehicle is the object containing the hashmap-variable
_item is the key-value in the hashmap
_value (optional) is the value to assign to the hashmap-key.
*/
params ["_vehicle", "_item", "_value"]; 

if(isNil "_vehicle")exitwith{};
if([_vehicle]call Tcore_fnc_deadCrew)exitWith{};

private _vehicleData = (_vehicle getVariable "SFSM_vehicleData");
if(isNil "_vehicleData")exitWith{};

private _returnVal = _vehicleData get _item;

if(isNil "_value")exitwith{_returnVal};

_vehicleData set [_item, _value];
_vehicle setVariable["SFSM_vehicleData", _vehicleData, true];

_value;