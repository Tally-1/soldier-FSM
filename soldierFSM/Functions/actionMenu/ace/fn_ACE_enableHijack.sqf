params["_vehicle"]; 
private _title     = "<t color='#f8aa45'>Allow vehicle hijacking.</t>";
private _condition = {
	params ["_target", "_caller"];
	Alive _target 
    && {(!(_target getVariable ['SFSM_allowHijack', false]))
    && {[_target] call Tcore_fnc_deadCrew}}
};
private _function  = {
	params ["_vehicle", "_caller", "_actionId", "_arguments"]; 
        _vehicle setVariable ["SFSM_allowHijack", true, true];
        _vehicle setObjectTexture ["clan", ""];
        hint "This vehicle can now be hijacked by AI.";
};

[
	_vehicle,
	_title,
	_condition,
	_function

] call SFSM_fnc_ACE_objectActionSimple;

true;