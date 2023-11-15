params["_man"];
private _title     = "<t color='#f8aa45'>Execute</t>";
private _condition = { 
	params ["_target", "_caller"];
    alive _target 
	&& {handgunWeapon _caller isNotEqualTo ''}
};

private _function = { 
	params ["_target", "_caller"];
    [_target, _caller] remoteExec ["SFSM_fnc_execute", (owner _target)];
};

private _actionData = 
[
	_man,
	_title,
	_condition,
	_function

] call SFSM_fnc_ACE_objectActionSimple;

_man setVariable ["SFSM_Ace_ExecuteActionData", _actionData, true];

true;