params["_fipo"]; 
private _cooldown = [_fipo] call SFSM_fnc_fipoCooldownLeft;
private _text  = "Hit And Run position.";

if(_cooldown > 0)exitWith{
	_text  = [
	"Hit And Run cooldown, ",
	_cooldown,
	" seconds left"

	]joinString"";
	
	_text;
};

private _timeUntilExit = [_fipo] call SFSM_fnc_fipoTimeUntilExit;
if(_timeUntilExit isNotEqualTo -1)exitWith{
	_text  = [
	"Hit And Run, Exit in ",
	_timeUntilExit,
	" seconds"

	]joinString"";
	
	_text;
};

_text;