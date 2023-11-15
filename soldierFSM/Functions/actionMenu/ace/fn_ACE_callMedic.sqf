params["_man"];
private _title     = "<t color='#dc6946'>Call for Medic!</t>";
private _condition = { [(_this#0)] call SFSM_fnc_canCallMedic;};
private _function  = { [] spawn SFSM_fnc_callPlayerMedic;};
[
	_man,
	_title,
	_condition,
	_function
] call SFSM_fnc_ACE_simpleSelfAction;

true;