/*
Retrieves or stores data from the SFSM_UnitData hashmap.
_man is the object containing the hashmap-variable
_item is the key-value in the hashmap
_value (optional) is the value to assign to the hashmap-key.
*/
params ["_man", "_item", "_value"]; 

if!(_man isKindOf "man")exitwith{};

private _unitData = (_man getVariable "SFSM_UnitData");

if(isNil "_unitData")
exitWith{
			if(SFSM_Debugger
			&&{!([_man] call SFSM_fnc_isRealMan)})
			then{diag_log ([("unitData is nil "), (typeOf _man)])};
			nil
		};

private _returnVal = _unitData get _item;

if(isNil "_value")exitwith{_returnVal};

_unitData set [_item, _value];
_man setVariable["SFSM_UnitData", _unitData, true];

_value;