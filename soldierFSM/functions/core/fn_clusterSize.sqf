params ["_center", "_clusterMembers"];
if(count _clusterMembers < 2)exitWith{2};
private _distances = [];
if(isNil "_center")then{["nil pos", 2] call SFSM_fnc_debugMessage};

{
    if(!isNil "_center")
    then{_distances pushback (_x distance2D _center)}    
} forEach _clusterMembers;

private _clusterRadius = selectMax _distances;

if(isNil "_clusterRadius")then{_clusterRadius = 2};

_clusterRadius