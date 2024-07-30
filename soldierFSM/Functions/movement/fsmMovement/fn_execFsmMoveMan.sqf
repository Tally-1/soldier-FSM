params [ 
    ["_man",       nil, [objNull]],      // The man that will move.
    ["_position",  nil,      [[]]],     //  Target position
    ["_time",      nil,       [0]],    //   Timeout (max time to attempt to reach said pos)
    ["_cRadius",   3,         [0]],   //    Completion radius (distance to wanted pos before move can be considered complete).
    ["_endCode",   nil,      [[]]],  //    Function to be run on completion [[params],{_code}]
    ["_condition", [],       [[]]], //     Boolean function, if it returns false the move will be aborted. [[params],{_code}]
    ["_cndFreq",   0.1,       [0]] //      How often the custom condition is checked 
];
private _whileSleep    = selectMin [0.1, _cndFreq];
private _continue      = true;

_man doFSM ["SoldierFSM\move.fsm", _position, objNull];

while {sleep _whileSleep; _continue} do { 
	_continue = [_man, true] call SFSM_fnc_moveManFsmCondition;
	if!(_continue)exitWith{};
	[_man] call SFSM_fnc_whileManFsmMoving;
};

private _timer  = time+3;
private _endNow = _man getVariable "FSM_endedMove";

waitUntil { 
	private _ended = _man getVariable "FSM_endedMove";
    if(isNil "_ended")exitWith{true};

	_endNow        = _ended || {time>_timer};
    if(isNil "_endNow")exitWith{true};
	_endNow;
};

true;