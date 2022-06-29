private _standHeight = false;
params["_man", "_enemies", "_standHeight"];
private _target   = objNull;
private _startPos = ASLToAGL (eyePos _man);

if(_standHeight)
then{_startPos = [_startPos#0, _startPos#1, 1.7]};

_startPos = AGLToASL _startPos;

private _nearest  = [_man, _enemies] call Tcore_fnc_nearestPos;
private _canSee = [_man, "VIEW", _nearest] checkVisibility [_startPos, aimPos _nearest];

if(_canSee > 0.3)exitWith{_nearest};

{
	_canSee = [_man, "VIEW", _x] checkVisibility [_startPos, aimPos _x];
	if(_canSee > 0.1)exitWith{_target = _x};
} forEach _enemies;

_target;