params [ 
    ["_man",         nil, [objNull]],      // The man that will move.
    ["_targetPos",   nil,      [[]]],     //  Target position
    ["_maxTime",     nil,       [0]],    //   Timeout (max time to attempt to reach said pos)
    ["_maxDistance", nil,       [0]],   //    Distance to wanted pos before aborting move.
    ["_condition",   nil,      [[]]]   //     Boolean function to be called on each step of path (If calculated)
];
_condition params [
    ["_conditionParams",[],[[]]],
    ["_conditionCode",  {true},[{}]]
];

private _startPos     = getPosATLVisual _man;
private _path         = _man getVariable "SFSM_currentPath";
private _startTime    = time;
private _pathDistance = [_path] call SFSM_fnc_getPathDistance;

[_man, "Path calculated"] spawn SFSM_fnc_flashAction;
_man doFollow _man;

for "_i"from 0 to (count _path -1)
do {
    private _continue = _conditionParams call _conditionCode;
    private _nextPos  = _path#0;
    if(_continue isEqualTo false)                        exitWith{};
    if(isNil "_nextPos")                                 exitWith{};
    if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{};
    if([_man, "inFipo"] call SFSM_fnc_unitData)          exitWith{};
    // if(_this call SFSM_fnc_forcedMoveSprint)             exitWith{};

    // private _k = 0;
    // SFSM_Custom3Dpositions = _path apply {_k=_k+1;[_x, str round (_x#2)]};
    private _distance     = _man distance _nextPos;
    private _pathDistance = [_path] call SFSM_fnc_getPathDistance;
    private _timeSpent    = time - _startTime;
    private _timeLeft     = ceil _maxTime - _timeSpent;

    if(_distance <= 0)     then{_distance     = 0.01;};
    if(_pathDistance <= 0) then{_pathDistance = 0.01;};

    private _distCoef     = _distance/_pathDistance;
    private _posTimeLimit = _timeLeft * _distCoef;
    
    [_man, _startPos, _startTime] call SFSM_fnc_forcedMoveProne;
    
    [
        _man,
        _nextPos,
        _posTimeLimit,
        _maxDistance
    ]
    call SFSM_fnc_forcedMoveToPos;

    [_man, "forcedMovement", true] call SFSM_fnc_unitData;
    _path deleteAt 0; 

};

if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{true;};
if([_man, "inFipo"] call SFSM_fnc_unitData)          exitWith{true;};

private _pathMoveFailed = [
        _man,
        _startTime,
        _maxTime,
        _startPos,
        _targetPos

    ] call SFSM_fnc_forcedMoveHasFailed;

if(_pathMoveFailed isEqualTo true)exitWith{false;};

true;