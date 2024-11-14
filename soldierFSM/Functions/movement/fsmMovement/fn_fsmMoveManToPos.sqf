params [ 
    ["_man",       nil, [objNull]],      //The man that will move.
    ["_position",  nil,      [[]]],     // Target position
    ["_time",      nil,       [0]],    //  Timeout (max time to attempt to reach said pos)
    ["_cRadius",   3,         [0]],   //   Completion radius (distance to wanted pos before move can be considered complete).
    ["_endCode",   nil,      [[]]],  //    Function to be run on completion [[params],{_code}]
    ["_condition", [],       [[]]], //     Boolean function, if it returns false the move will be aborted. [[params],{_code}]
    ["_cndFreq",   0.1,       [0]] //      How often the custom condition is checked 
];

private _alreadyMoving = (_man getVariable ["FSM_moveEnded", true])isEqualTo false;
if(_alreadyMoving)
exitWith{[_man, "Double move"] spawn SFSM_fnc_flashAction};

private _canRunParams = [_man,nil,nil,nil,true];
private _canRun = isNil "SFSM_fnc_canRun"or{_canRunParams call SFSM_fnc_canRun};
if!(_canRun)
exitWith{[_man, "Move blocked"] spawn SFSM_fnc_flashAction};

private _useSFSM = (!isNil "SFSM_fnc_canRun")&&{_condition isEqualTo []};
if(_useSFSM)
then{_this set [5,[_canRunParams, SFSM_fnc_canRun]]};

_this call SFSM_fnc_initFsmMoveMan;
_this call SFSM_fnc_execFsmMoveMan;
_this call SFSM_fnc_endFsmMoveMan;

true;