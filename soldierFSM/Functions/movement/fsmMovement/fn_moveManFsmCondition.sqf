params [
    ["_man",           nil, [objNull]],
	["_checkDistance", false,  [true]],
	["_ignoreData",    false,  [true]]
];
(_man getVariable "FSM_moveParams")
params [
    ["_position",  nil, [[]]],
    ["_timeLimit", nil,  [0]],
    ["_cRadius",   nil,  [0]],
	["_condition", nil, [[]]],
	["_cndFreq",   nil,  [0]]
];

private _noData = isNil "_condition";
if(_noData)exitWith{ 
	if(_ignoreData)exitWith{true};
	false
};

private _aborted  = _man getVariable ["FSM_moveAborted", false];
if(_aborted)exitWith{false};

private _distance   = _man distance _position;
private _inDistance = _checkDistance && {_distance < _cRadius};
if(_inDistance)exitWith{false};

private _died = !alive _man;
if(_died)exitWith{false};

private _timedOut = time > _timeLimit;
if(_timedOut)exitWith{false};

private _repeats = _man getVariable ["FSM_movesRepeated", 0];
if(_repeats>5)exitWith{false};

private _noCondition = _condition isEqualTo [];
if(_noCondition)exitWith{true};

private _conditionCheckTime = _man getVariable ["FSM_conditionCheckTime", time-_cndFreq];
private _noConditionCheck   = time < _conditionCheckTime;
if(_noConditionCheck)exitWith{true};

_man setVariable ["FSM_conditionCheckTime", time+_cndFreq];
private _continue = (_condition#0)call(_condition#1);

_continue;