params["_man"]; 
private _title     = "Capture";
private _condition = {
	params ["_man", "_caller"];
    alive _man 
	&&{side (group _man) isNotEqualTo side _caller}
};
private _function = { 
	params ["_man", "_caller"];
    [_man, _caller] remoteExec ["SFSM_fnc_capture", (owner _man)];
};

private _actionData = 
[
	_man,
	_title,
	_condition,
	_function

] call SFSM_fnc_ACE_objectActionSimple;

_man setVariable ["SFSM_Ace_CaptureActionData", _actionData, true];

true;