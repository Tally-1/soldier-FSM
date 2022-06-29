/*See unitData for comments */
params ["_group", "_item", "_value"];

private _groupData = (_group getVariable "SFSM_groupData");

if(isNil "_groupData")
exitWith{
		"groupData is nil" call SFSM_fnc_debugMessage; 
		(str _group) call SFSM_fnc_debugMessage;
		[_group] call SFSM_fnc_initGroup;
		nil
		};

private _returnVal = _groupData get _item;

if(isNil "_value")exitwith{_returnVal};

_groupData set [_item, _value];
_group setVariable["SFSM_groupData", _groupData, true];

_value;