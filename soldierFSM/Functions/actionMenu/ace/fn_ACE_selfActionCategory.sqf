params["_player"];
//Initializes the base category for all ACE self-actions
private _categoryName = "SFSM_ACE_SelfActions";
private _baseCategory = _player getVariable "SFSM_ACE_baseCategory";
if(!isNil "_baseCategory")exitWith{_categoryName;};

private _baseCategory = [
	_categoryName,
	"Soldier FSM",
	"",
	{},
	{true}
] call ace_interact_menu_fnc_createAction;

[
	_player,
	1,
	["ACE_SelfActions"],
	_baseCategory

] call ace_interact_menu_fnc_addActionToObject;

_player setVariable ["SFSM_ACE_baseCategory", _categoryName];

_categoryName;