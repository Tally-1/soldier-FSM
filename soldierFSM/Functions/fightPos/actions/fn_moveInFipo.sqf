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

private _move = [_man, _fightingPos, 90] spawn SFSM_fnc_forceMove2;
private _aborted   = false;
private _startTime = time;
private _startPos  = getPosASLVisual _man;
private _teleport  = false;

waitUntil{
    //abort move in case the leader is out of range or the man is not moving.
    if (_leader distance2D _fipo > SFSM_fipoGetInDistance
    || {time - _startTime > 20
    && {_startPos distance2D _man < 10
    && {_man distance2D _fipo > 10
    && {speed _man < 3
    }}}})
    then{
        [_man] call SFSM_fnc_abortForcedMove;
        _aborted = true;
    };

    if([_man, _fipo] call SFSM_fnc_canTeleportFipo)then{
        [_man] call SFSM_fnc_abortForcedMove;
        _teleport = true;
    };

    sleep 0.1; 
    scriptDone _move;
};

if(_teleport)exitWith{
    [_man, _fipo] call SFSM_fnc_getInFipo;
};

if(_aborted)exitwith{
    [_man] call SFSM_fnc_failFipoMove;
};

if!([_man, true] call SFSM_fnc_canRun)exitWith{[_man] call SFSM_fnc_failFipoMove;};

private _manPos = (getPosATLVisual _man);

if(_manPos distance2D _fightingPos < 5
&&{_man distance _fightingPos > 1.6})then{
    _move = [_man, _fightingPos] spawn SFSM_fnc_forceMoveATL;
    waitUntil{sleep 0.1; scriptDone _move;};
};

if!([_man, true] call SFSM_fnc_canRun)exitWith{[_man] call SFSM_fnc_failFipoMove;};
if(_man distance2D _fightingPos > 5)  exitWith{[_man] call SFSM_fnc_failFipoMove;};

[_man, _fipo] call SFSM_fnc_getInFipo;




true;