params[
    ["_fipoList", SFSM_fipositions],
    ["_forced", false]
];
private _count = count _fipoList;

if(_fipoList isEqualTo []) exitWith{};
if(_count isEqualTo 0)     exitWith{};

if(isNil "SFSM_fipoAssigner" isEqualTo false
&&{_forced isEqualTo false})exitWith{};

SFSM_fipoAssigner = true;

private _isAcAz       = _fipoList isEqualTo SFSM_activeAzFipos;
private _startTime    = time;
private _squadLeaders = (allGroups apply {leader _x})select{[_x] call SFSM_fnc_isRealMan};
private _excludedMen  = [];

{
    if([_x] call SFSM_fnc_fipoAvailable)
    then{
            private _assignedMan = [_x, _squadLeaders, _excludedMen] call SFSM_fnc_assignFipo;
			if(alive _assignedMan)then{
                _excludedMen pushBackUnique _assignedMan;
            };
    };

    if(_isAcAz)
    then{SFSM_activeAzFipos deleteAt (SFSM_activeAzFipos find _x)};
    
} forEach _fipoList;


if(SFSM_debugger
&&{(count _excludedMen) > 0})then{
    private _timeSpent = round (time - _startTime);
    private _msg       = ["Assigned ", (count _excludedMen), " men to Fighting-Positions in ", _timeSpent, "s"];
    [_msg, 1] call dbgmsg;
};


if(_isAcAz)
then{
    private _timeSpent = round (time - _startTime);
    if(_timeSpent < 3)exitWith{};
    private _msg = ["Processed ", _count, " AZ-Fighting-Positions in ", _timeSpent, "s"];
    [_msg, 1] call dbgmsg;
};

SFSM_fipoAssigner = nil;

true;