params["_vehicle"]; 
private _title     = "<t color='#78db71'>Reserve vehicle</t>";
private _condition = {
	params ["_vehicle"];
	Alive _vehicle 
    && {_vehicle getVariable ['SFSM_allowHijack', false]
    && {[_vehicle] call Tcore_fnc_deadCrew}}
};
private _function  = {
	params ["_vehicle"]; 
    _vehicle setVariable ["SFSM_allowHijack", false, true];
    hint "This vehicle has now been protected against AI hijacking.";
    [
        _vehicle, 
        "No AI hijack", 
        "clan", 
        0.2,
        "#00ffff",
        "#00000000",
        "PuristaBold"
    ] call Tcore_fnc_setTextTexture;
};

[
	_vehicle,
	_title,
	_condition,
	_function

] call SFSM_fnc_ACE_objectActionSimple;

true;