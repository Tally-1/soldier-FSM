params[
    ["_man",       nil, [objNull]],
    ["_startTime", nil,       [0]],
    ["_maxTime",   nil,       [0]],
    ["_startPos",  nil,      [[]]],
    ["_targetPos", nil,      [[]]]
];  
private _moveFailed = false;

isNil{
private _endPos          = getPosATLVisual _man;
private _wantedDistance  = _startPos distance _targetPos;
private _distanceMoved   = _startPos distance _endPos;
private _distToTargetPos = _endPos distance _targetPos;
private _timeSpent       = time - _startTime;
private _timeLimit       = round (_maxTime*0.9);

if(_distanceMoved   >  3)    exitWith {false;};
if(_wantedDistance  < 10)    exitWith {false;};
if(_distToTargetPos <= 5)    exitWith {false;};
if(_timeSpent       < 10)    exitWith {false;};
if(_timeSpent < _timeLimit)  exitWith {false;};

_moveFailed = true;
};

_moveFailed;