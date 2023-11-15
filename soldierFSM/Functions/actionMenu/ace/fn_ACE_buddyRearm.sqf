params["_man"];
private _title     = "<t color='#dc6946'>Call for Ammo!</t>";
private _condition = { [(_this#0)] call SFSM_fnc_canCallBuddyRearm;};
private _function  = { [] spawn SFSM_fnc_buddyRearm;};
[
	_man,
	_title,
	_condition,
	_function
] call SFSM_fnc_ACE_simpleSelfAction;

true;