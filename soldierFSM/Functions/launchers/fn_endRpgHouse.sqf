params[
    ["_man",      nil, [objNull]],
    ["_success",  nil, [false]]
];

private _buildingVarName = [_man, "targetBuilding"] call SFSM_fnc_unitData;
private _building        = missionNamespace getVariable [_buildingVarName, objNull];
private _buildingPos     = [_building] call SFSM_fnc_buildingCenterPosASL;
private _pos             = getPosATLVisual _man;
private _leader          = leader group _man;

_man doMove _pos;
_man doFollow _leader;

[_man, "targetBuilding", "none"]                    call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]]               call SFSM_fnc_unitData;
[_man, "action", "none"]                            call SFSM_fnc_unitData;

missionNamespace setVariable [_buildingVarName, nil];
_man             setVariable ["SFSM_missileTarget", nil];

if!(alive _man) exitWith{"Man died before launching RPG" call dbgmsg;};
if (_success)   exitWith{[_man, "Building targeted successfully!"] call SFSM_fnc_flashAction;};

private _endMsg = "RPG on house failed";
private _canSee = ([_man, "VIEW", _building] checkVisibility [aimPos _man, _buildingPos])>0.8;

if!(_canSee)then{_endMsg = "failed to get LOS on the building";};

[_man, _endMsg] spawn SFSM_fnc_flashAction;

true;