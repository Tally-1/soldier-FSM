if(!isNil "SFSM_capKeyDown")
exitWith{hint parseText("No spam allowed...<br/> Wait 1-2 seconds and try again...")};

SFSM_capKeyDown     = true;
SFSM_capKeyDownTime = time;

private _actionTime = SFSM_cptrPlrEscTime;
private _timer      = time+_actionTime;
private _timedOut   = false;
private _buttonDown = player getVariable "SFSM_breakingCuffs";
private _completion = 0;

while {_buttonDown isEqualTo true
&&    {_timedOut   isEqualTo false}} do {

		sleep 0.1;

		_timedOut = time > _timer;
		_buttonDown = player getVariable "SFSM_breakingCuffs";

		if!(_buttonDown) exitWith{hint "Button released early..."; sleep 0.5;};

		_completion = [_timer, _actionTime] call SFSM_fnc_breakOutHint;
};

[]spawn{sleep 1; SFSM_capKeyDown = nil;};

private _success       = (random 1 < SFSM_cptrPlrEscProb) &&{_completion >= 100;};
private _msg           = parseText("Success! <br/><br/>You are free!");
if!(_success)then{_msg = parseText("Failure! <br/><br/>Try Again!");};

hint _msg;

if(_success)exitWith{[] call SFSM_fnc_endPlayerCapture;};

true;