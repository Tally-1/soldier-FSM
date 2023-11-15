params["_man"];
private _title     = "<t color='#f8aa45'>Calm down</t>";
private _condition = {
	params ["_man", "_caller"];
    alive _man 
	&&{side (group _man) isEqualTo side _caller}
};

private _function = { 
	params ["_man", "_caller"];
    [_man, _caller] remoteExec ["SFSM_fnc_calmPanicked", (owner _man)];
	_man getVariable "SFSM_Ace_PanicActionData"
	params["_parentPath", "_actionName"];
	[_man, _parentPath, _actionName] remoteExec ["SFSM_fnc_ACE_removeObjectAction", 0];
	_man setVariable ["SFSM_Ace_PanicActionData", nil, true];
};

private _actionData = 
[
	_man,
	_title,
	_condition,
	_function

] call SFSM_fnc_ACE_objectActionSimple;

_man setVariable ["SFSM_Ace_PanicActionData", _actionData, true];

true;