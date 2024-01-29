private _forced = false;
params["_man", "_fipo", "_forced"];

// If the move is not forced, and the man is not "allowed" then abort the move.
if(_forced                                            isEqualTo false 
&&{([_man, _fipo, true] call SFSM_fnc_canMoveInFipo)  isEqualTo false
})exitWith{
    [_man, "Cannot get into fipo"] spawn SFSM_fnc_flashAction;
    [["Man cannot move into fipo "], 1] call dbgmsg;
};

private _leader = leader group _man;
private _fightingPos = getPosATLVisual _fipo;

_man synchronizeObjectsAdd [_fipo];

[_man, "Moving to fighting position"] call SFSM_fnc_setAction;
["fipo_moveIn",  [_man, _fipo]] call CBA_fnc_localEvent;

if([_man, _fipo] call SFSM_fnc_canTeleportFipo)exitWith{
    [_man] call SFSM_fnc_abortForcedMove;
    [_man, _fipo] call SFSM_fnc_getInFipo;
};

private _move = [_man, _fightingPos, 90] spawn SFSM_fnc_forcedMove;
private _startTime = time;
private _startPos  = getPosASLVisual _man;
private _aborted   = false;
private _teleport  = false;

waitUntil{
    //abort move in case the leader is out of range or the man is not moving.
    private _status = [
        _man, 
        _leader, 
        _fipo, 
        _startTime, 
        _startPos

    ] call SFSM_fnc_fipoMoveInStatus;

    if(isNil "_status")then{
        _status = "abort"
    };

    _aborted  = _status isEqualTo "abort";
    _teleport = _status isEqualTo "teleport";

    sleep 0.1; 
    scriptDone _move;
};
private _canMove = [_man, true] call SFSM_fnc_canRun;
private _manPos  = (getPosATLVisual _man);

if(_teleport isEqualTo true)  exitWith {[_man, _fipo] call SFSM_fnc_getInFipo;   };
if(_aborted  isEqualTo true)  exitwith {[_man]        call SFSM_fnc_failFipoMove;};
if(_canMove  isEqualTo false) exitWith {[_man]        call SFSM_fnc_failFipoMove;};



if(_manPos distance2D _fightingPos < 5
&&{_man distance _fightingPos > 1.6})then{
    [_man, _fightingPos] call SFSM_fnc_forceMoveATL;
};

if!([_man, true] call SFSM_fnc_canRun) exitWith{[_man] call SFSM_fnc_failFipoMove;};
if (_man distance2D _fightingPos > 5)  exitWith{[_man] call SFSM_fnc_failFipoMove;};

[_man, _fipo] call SFSM_fnc_getInFipo;

true;