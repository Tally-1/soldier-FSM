/*
Retrieves or stores data from the SFSM_UnitData hashmap.
_man is the object containing the hashmap-variable
_item is the key-value in the hashmap
_value (optional) is the value to assign to the hashmap-key.
*/
params ["_man", "_item", "_value"];

private _unitData = (_man getVariable "SFSM_UnitData");
private _returnVal = _unitData get _item;

if(isNil "_value")exitwith{_returnVal};

_unitData set [_item, _value];
_man setVariable["SFSM_UnitData", _unitData, true];

true;