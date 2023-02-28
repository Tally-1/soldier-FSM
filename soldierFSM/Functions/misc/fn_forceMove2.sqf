private _maxTime = 30;
private _maxDistance = 1.1;
private _spamTimer = 0.5;
params [
	"_man",            // the man that will move.
	"_pos",           //  target position
	"_maxTime",      //   timeout (max time to attempt to reach said pos)
	"_maxDistance", //    distance to wanted pos before aborting move.
	"_spamTimer"   //     how often the doMove command is repeated.
	];


if([_man, _pos] call SFSM_fnc_canSprint)exitWith{

	private _sprint = [_man, _pos] spawn SFSM_fnc_sprint;
	waitUntil{sleep 0.3; scriptDone _sprint;};

	private _move = _this spawn SFSM_fnc_forceMoveToPos;
	waitUntil { sleep 0.1; scriptDone _move; };

};

private _timer     = time + 3.2;
private _calculate = [_man, _pos, 3] spawn SFSM_fnc_calculatePath;
[_man, "Calculating path"] spawn SFSM_fnc_flashAction;
waitUntil {(scriptDone _calculate) || (_timer < time); };

private _path = _man getVariable "SFSM_currentPath";
if(isNil "_path")exitWith{
	private _move = _this spawn SFSM_fnc_forceMoveToPos;
	waitUntil { sleep 0.1; scriptDone _move; };
};

"Path calculated" call dbgmsg;

[_man, "Path calculated"] spawn SFSM_fnc_flashAction;


private _posTimeLimit = _maxTime / (count _path);
{
	private _move = 
	[
		_man,
		_x,
		_posTimeLimit,
		1,
		_spamTimer
	]
	spawn SFSM_fnc_forceMoveToPos;

	waitUntil { sleep 0.1; scriptDone _move; };
	
} forEach _path;

_man setVariable ["SFSM_currentPath", nil, true]; 