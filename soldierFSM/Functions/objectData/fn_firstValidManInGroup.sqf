params [
    ['_group',nil,[grpNull]]
];
private _leader = leader _group;
if([_leader] call SFSM_fnc_functionalMan)exitWith{_leader};

private ["_man"];
{
    if(!isNil "_man")exitWith{};
    if([_x] call SFSM_fnc_functionalMan)exitWith{_man = _x};
} forEach units _group;
if(isNil "_man")exitWith{};

_man;