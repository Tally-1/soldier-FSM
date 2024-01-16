params[
    ["_man",       nil, [objNull]],
    ["_startPos",  nil,      [[]]],
    ["_targetPos", nil,      [[]]]
];
if!([_man, true] call SFSM_fnc_canRun)exitWith{false;};

private _failList = _man getVariable "SFSM_UnitData" get "failedForcedMoves";
private _count    = count _failList;
private _endPos   = getPosATLVisual _man;
private _distance = _endPos distance _startPos;

private _moveData = [
    time,
    _distance,
    _startPos,
    _targetPos,
    _endPos
];

_failList pushBack _moveData;
if(_count > 30)then{_failList deleteAt 0;};

[_man, "forced-move failed TOTALLY!", 0.5] spawn SFSM_fnc_flashAction;
[_man] call SFSM_fnc_resetBrain;
[_man] call SFSM_fnc_isBrainDead;

[["Complete move fail. Time: ", round time],2] call dbgmsg;
_man getVariable "SFSM_UnitData" set ["failedForcedMoves", _failList];

true;