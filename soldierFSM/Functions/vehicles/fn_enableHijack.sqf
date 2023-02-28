params["_vehicle"];

private _condition = "Alive _target 
                   && {(!(_target getVariable ['SFSM_allowHijack', false]))
				   && {[_target] call Tcore_fnc_deadCrew}}";

private _title = "<t color='#f8aa45'>Allow vehicle hijacking.</t>";

[_vehicle,
[
	_title,	    // title
	{
		params ["_vehicle", "_caller", "_actionId", "_arguments"]; 
		_vehicle setVariable ["SFSM_allowHijack", true, true];
		hint "This vehicle can now be hijacked by AI.";
	},
	nil,		// arguments
	1.5,        // priority
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