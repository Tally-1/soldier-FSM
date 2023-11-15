params["_man"];
private _title     = "<t color='#dc6946'>Enable Autostance</t>";
private _condition = { 
	private _disabeled = (group player) getVariable ['SFSM_noAutoStance', false];
	if (_disabeled) exitWith {false};
	([_this#0, _this#1] call SFSM_fnc_showAutoStAction);
};
private _function  = { 
	hint "Autostance disabled.";
	private _group = group (_this#0);
    _group setVariable ["SFSM_noAutoStance", true, true];  
};
[
	_man,
	_title,
	_condition,
	_function
] call SFSM_fnc_ACE_simpleSelfAction;

true;