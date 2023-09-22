private _allfipos  = [SFSM_allfipos, 4] call SFSM_fnc_splitArr;
private _threads   = [];
private _startTime = time;

{
	private _script = [_x, true] spawn SFSM_fnc_fipoAssigner;
	_threads pushBack _script;
} forEach _allfipos;

waitUntil { sleep 1; [_threads] call SFSM_fnc_threadsFinished;};

private _timeSpent = round (time - _startTime);
private _msg = ["Processed All FIPOS in ", _timeSpent, "s"];
[_msg, 1] call dbgmsg;

true;