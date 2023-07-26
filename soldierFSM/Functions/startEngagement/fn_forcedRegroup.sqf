params["_man"];
private _regroupNeeded = [_man] call SFSM_fnc_forcedRegroupNeeded;
if!(_regroupNeeded)exitWith{false};

// Some may argue that the following should be in a separate function-file,
// however this solution allows for a one line call to the function,
// combining both scheduled and unscheduled execution.

[_man] spawn {
    params["_man"];

    
    [_man, "Forced regroup"] call SFSM_fnc_setAction;
    
    private _pos  = formationPosition _man;
    private _timeLimit = 60;
    private _timer = time + _timeLimit;
    private _move = [_man, _pos, _timeLimit] spawn SFSM_fnc_forceMove2;

    _man spawn{
        sleep 70;
        if([_this] call SFSM_fnc_getAction isEqualTo "Forced regroup")then{
            [_this, "abortForcedMove", true] call SFSM_fnc_unitData;
            [_this, "none"] call SFSM_fnc_setAction;
        };
    };
    
    waitUntil { 
        sleep 1; 
        if(scriptDone _move)exitWith{true;};

        private _leader     = (leader group _man);
        private _distance   = _man distance2D  _leader;
        private _nearLeader = _distance < SFSM_specRegroupDist;
        private _deadLeader = !alive _leader;

        if(_nearLeader
        ||{_deadLeader
        ||{time>_timer}})then{
            [_man, "abortForcedMove", true] call SFSM_fnc_unitData;
        };

        scriptDone _move;
    };

    _man doFollow (leader group _man);

    [_man, "none"] call SFSM_fnc_setAction;
};

true;