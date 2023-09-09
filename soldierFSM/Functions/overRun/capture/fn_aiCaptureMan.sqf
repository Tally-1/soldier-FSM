params ["_captive", "_captor"];

private _canCapture = [_captive, _captor, false, true] call SFSM_fnc_canCapture;
if!(_canCapture)exitWith{[_captive, _captor] call SFSM_fnc_failAiCapture};

// private _capture = 
[_captive, _captor] call SFSM_fnc_capture;
// waitUntil{sleep 0.5; scriptDone _capture; };

[_captor,  "none"] call SFSM_fnc_setAction;
[_captor,  "capture completed"] spawn SFSM_fnc_flashAction;