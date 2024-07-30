params [
    ["_man",    nil, [objNull]],
	["_target", nil, [objNull]]
];
private _distance = _man distance _target;
if(_distance > 100)exitWith{false};

private _lastVcheck = _target getVariable ["FSM_lastLOScheck", time-2];
if(time - _lastVcheck < 1)exitWith{true};

private _visible = ([_man, "VIEW", _target] checkVisibility [(aimPos _man), (aimPos _target)])isEqualTo 1;

_target setVariable ["FSM_lastLOScheck", time];

_visible;