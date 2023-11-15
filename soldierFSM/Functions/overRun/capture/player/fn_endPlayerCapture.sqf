private _captor  = player getVariable "SFSM_myCaptor";
private _abused  = _captor getVariable "SFSM_abuser";
private _display = findDisplay 46;
private _downId  = player getVariable "SFSM_captureKeyDown";
private _upId    = player getVariable "SFSM_captureKeyUp";

if(_abused)then{
	_captor setVariable ["SFSM_abuser", false, true];
	[player, _captor, true] call SFSM_fnc_endCaptureAbuse;
};
_display displayRemoveEventHandler ["KeyDown", _downId];
_display displayRemoveEventHandler ["KeyUp",   _upId];

player setVariable ["SFSM_captureKeyDown", nil];
player setVariable ["SFSM_captureKeyUp",   nil];

[player] call SFSM_fnc_endCapture;