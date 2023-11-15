params[
	"_player",
	"_title",
	"_condition",
	"_code",
	["_icon", ""],
	["_category", nil]
];
if(isNil "_category")
then{   _category = [_player] call SFSM_fnc_ACE_selfActionCategory;};
private _parentPath = ["ACE_SelfActions", _category];
private _actionType = 1;
private _actionName = ["SFSM_ACE_SelfActions ", _title]joinString"";

private _action = [
	_actionName,
	_title,
	_icon,
	_code,
	_condition
] call ace_interact_menu_fnc_createAction;

[
	_player,
	_actionType,
	_parentPath,
	_action

] call ace_interact_menu_fnc_addActionToObject;

[_parentPath, _actionName];