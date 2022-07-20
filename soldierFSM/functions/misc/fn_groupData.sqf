/*See unitData for comments */
params ["_group", "_item", "_value"];

private _groupData = (_group getVariable "SFSM_groupData");

if(isNil "_groupData")
exitWith{
		if(SFSM_Debugger)then{diag_log "groupData is nil"};
		// [_group] call SFSM_fnc_initGroup;
		// _this call SFSM_fnc_groupData;
		nil
		};

private _returnVal = _groupData get _item;

if(isNil "_value")exitwith{_returnVal};

_groupData set [_item, _value];
_group setVariable["SFSM_groupData", _groupData, true];

_value;