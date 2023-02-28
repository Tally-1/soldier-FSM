private _forceLeave = false;
params["_battlefield", "_forceLeave"];
if(isNil "_battlefield")exitWith{};

private _groups = (missionNamespace getVariable (_battlefield get "groups"));
if(isNil "_groups")exitWith{};

{[_x, _forceLeave] call SFSM_fnc_groupLeaveTurrets;} forEach _groups;

true;