params[
    "_captive", 
    "_captor",
    ["_forceAbuse", false],
    ["_forceExecution", false]
];
_captor disableAI "path";

[_captive, _captor] call SFSM_fnc_initUnconCapture;
[_captive] remoteExecCall ["SFSM_fnc_removeCaptureAction", 0];
[_captive] remoteExecCall ["SFSM_fnc_executeAction", 0];
[_captive] call SFSM_fnc_captureKillEh;
[_captive] call SFSM_fnc_captureHitEh;
[_captive] call SFSM_fnc_setCaptured;

_captor enableAI "path";

private _bombed =
[_captive, _captor] call SFSM_fnc_bombOnCapture;


if(_bombed)exitWith{false;};

sleep 1;

["capture",  [_captive, _captor]] call CBA_fnc_localEvent;
[_captive, _captor] remoteExec ["SFSM_fnc_capturePlayer", _captive];
[_captive] spawn SFSM_fnc_postCapture;

if([_captive, _captor, _forceAbuse]     call SFSM_fnc_allowCaptureAbuse)then{
   [_captive, _captor, _forceExecution] spawn SFSM_fnc_captureAbuse;
};

[[name _captive, " was captured by ", (name _captor)],1] call dbgmsg;

true;