params[
	"_captive", 
	"_captor",
	["_forceExecution", false]
];
private _anchor = [_captive, _captor] call SFSM_fnc_initCaptureAbuse;

_this spawn{
	sleep 0.1; 
	detach (_this#0);
	detach (_this#1);
};

private _captorParams = [_captive, _captor, _forceExecution] call SFSM_fnc_captorAbuseAnimParams;
_captorParams call SFSM_fnc_playAnimList;



[_captive, _captor] call SFSM_fnc_endCaptureAbuse;

true;