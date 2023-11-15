params[
	"_object",
	"_title",
	"_condition",
	"_code",
	["_icon", ""]
];

private _parentPath = ["ACE_MainActions"];
private _actionType = 0;
private _actionName = ["SFSM_ACE_MainActions ", _title]joinString"";

private _action = [
	_actionName,
	_title,
	_icon,
	_code,
	_condition
] call ace_interact_menu_fnc_createAction;

[
	_object,
	_actionType,
	_parentPath,
	_action

] call ace_interact_menu_fnc_addActionToObject;

[_parentPath, _actionName];