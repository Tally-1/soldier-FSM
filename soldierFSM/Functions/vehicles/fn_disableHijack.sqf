params["_vehicle"];

private _condition = "Alive _target 
                   && {_target getVariable ['SFSM_allowHijack', false]
				   && {[_target] call Tcore_fnc_deadCrew}}";

private _title = "<t color='#78db71'>Reserve vehicle</t>";

[_vehicle,
[
	_title,	    // title
	{
		params ["_vehicle", "_caller", "_actionId", "_arguments"]; 
		_vehicle setVariable ["SFSM_allowHijack", false, true];
		hint "This vehicle has now been protected against AI hijacking.";
	},
	nil,		// arguments
	1.5,	    // priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	_condition, // condition
	5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
]] 
remoteExecCall ["addAction", 0, true];