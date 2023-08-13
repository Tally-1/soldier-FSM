if(!isNil "SFSM_fipoAssigner")exitWith{};
SFSM_fipoAssigner = true;


private _squadLeaders = (allGroups apply {leader _x})select{[_x] call SFSM_fnc_isRealMan};
private _excludedMen  = [];
{
    if([_x] call SFSM_fnc_fipoAvailable)
    then{
            private _assignedMan = [_x, _squadLeaders, _excludedMen] call SFSM_fnc_assignFipo;
			if(alive _assignedMan)then{_excludedMen pushBackUnique _assignedMan;};
    };
    
} forEach SFSM_fipositions;

if(SFSM_debugger
&&{(count _excludedMen) > 0})then{
    [["Assigned ", (count _excludedMen), " men to Fighting-Positions"], 1] call dbgmsg;
};


SFSM_fipoAssigner = nil;

true;