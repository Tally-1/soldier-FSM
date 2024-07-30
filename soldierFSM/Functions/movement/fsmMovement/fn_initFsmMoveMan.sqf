params [ 
    ["_man",       nil, [objNull]],      // The man that will move.
    ["_position",  nil,      [[]]],     //  Target position
    ["_time",      nil,       [0]],    //   Timeout (max time to attempt to reach said pos)
    ["_cRadius",   3,         [0]],   //    Completion radius (distance to wanted pos before move can be considered complete).
    ["_endCode",   nil,      [[]]],  //    Function to be run on completion [[params],{_code}]
    ["_condition", [],       [[]]], //     Boolean function, if it returns false the move will be aborted. [[params],{_code}]
    ["_cndFreq",   0.1,       [0]] //      How often the custom condition is checked 
];
private _distance = _man distance _position;
if(isNil "_time")then{_time = _distance};
if(_time < 10)   then{_time = 10};

private _canTARGET     = _man checkAIFeature "TARGET";
private _canAUTOCOMBAT = _man checkAIFeature "AUTOCOMBAT";
private _canAUTOTARGET = _man checkAIFeature "AUTOTARGET";
private _timeLimit     = time + _time;
private _aiSettings    = [_canTARGET, _canAUTOCOMBAT, _canAUTOTARGET];
private _params        = [_position, _timeLimit, _cRadius, _condition, _cndFreq];


_man setVariable ["FSM_moveParams",            _params]; // used as inside the FSM, and in the while loop
_man setVariable ["FSM_moveAborted",             false]; // used as a condition inside the FSM 
_man setVariable ["FSM_moveEnded",               false]; // used to check if this function is already running
_man setVariable ["FSM_moveStart",                time];
_man setVariable ["FSM_aiSettings",        _aiSettings];
_man setVariable ["FSM_movesRepeated",               0];
_man setVariable ["FSM_startPos", getPosATLVisual _man];
_man setVariable ["FSM_startTime",                time];

_man disableAI "TARGET";
_man disableAI "AUTOCOMBAT";
_man disableAI "AUTOTARGET";

_man setBehaviour "AWARE";
_man doMove _position;

if(_canAUTOTARGET)             
then{[_man] call SFSM_fnc_addMoveManFsmCombatEh};

if(!isNil "SFSM_fnc_unitData") 
then{[_man, "forcedMovement", true] call SFSM_fnc_unitData};

true;