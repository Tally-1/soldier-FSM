private _captor  = player getVariable "SFSM_myCaptor";
private _abused  = _captor getVariable ["SFSM_abuser", false];
private _display = findDisplay 46;
private _downId  = player getVariable "SFSM_captureKeyDown";
private _upId    = player getVariable "SFSM_captureKeyUp";
private _eh      = player getVariable "SFSM_pCapEhKill"; 

if(_abused)then{
	_captor setVariable ["SFSM_abuser", false, true];
	[player, _captor, true] call SFSM_fnc_endCaptureAbuse;
};

if(!isNil "_downId") then {_display displayRemoveEventHandler ["KeyDown", _downId]};
if(!isNil "_upId")   then {_display displayRemoveEventHandler ["KeyDown", _upId]};
if(!isNil "_eh")     then {player removeEventHandler ["Killed", _eh]};

player setVariable ["SFSM_captureKeyDown", nil];
player setVariable ["SFSM_captureKeyUp",   nil];
player setVariable ["SFSM_pCapEhKill",     nil];

[player] call SFSM_fnc_endCapture;