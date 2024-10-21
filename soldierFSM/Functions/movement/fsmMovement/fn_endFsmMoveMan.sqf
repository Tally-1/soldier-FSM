params [ 
    ["_man",       nil, [objNull]],      // The man that will move.
    ["_position",  nil,      [[]]],     //  Target position
    ["_time",      nil,       [0]],    //   Timeout (max time to attempt to reach said pos)
    ["_cRadius",   3,         [0]],   //    Completion radius (distance to wanted pos before move can be considered complete).
    ["_endCode",   nil,      [[]]],  //    Function to be run on completion [[params],{_code}]
    ["_condition", [],       [[]]], //     Boolean function, if it returns false the move will be aborted. [[params],{_code}]
    ["_cndFreq",   0.1,       [0]] //      How often the custom condition is checked 
];
(_man getVariable "FSM_aiSettings")params[
    ["_canTARGET",     nil,[true]],
    ["_canAUTOCOMBAT", nil,[true]],
    ["_canAUTOTARGET", nil,[true]]
];


if(_canTARGET)     then{_man enableAI "TARGET"};
if(_canAUTOCOMBAT) then{_man enableAI "AUTOCOMBAT"};
if(_canAUTOTARGET) then{
	_man enableAI "AUTOTARGET";
	[_man] call SFSM_fnc_removeMoveManFsmCombatEh
};

_man setVariable ["FSM_moveEnded",         true]; 
_man setVariable ["FSM_moveParams",         nil];
_man setVariable ["FSM_conditionCheckTime", nil];
_man setVariable ["FSM_moveStart",          nil];
_man setVariable ["FSM_movesRepeated",      nil];
_man setVariable ["FSM_moveAborted",        nil];
_man setVariable ["FSM_CQB",                nil];
_man setVariable ["FSM_lastCqbCheck",       nil];

if(!isNil "SFSM_fnc_unitData") 
then{[_man, "forcedMovement", false] call SFSM_fnc_unitData};

if(!isNil "_endCode")
then{(_endCode#0)call(_endCode#1)};

_distance = _man distance _position;
if(_distance > _cRadius)exitWith{false};

true;