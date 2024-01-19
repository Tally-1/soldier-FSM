params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]],
    ["_launchPos", nil,      [[]]]
];

private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
missionNamespace setVariable [_buildingVarName, _building];

[_man, "currentDestination", _launchPos]              call SFSM_fnc_unitData;
[_man, "action", "CQB: Engaging house with launcher"] call SFSM_fnc_unitData;
[_man, "targetBuilding", _buildingVarName]            call SFSM_fnc_unitData;

true;