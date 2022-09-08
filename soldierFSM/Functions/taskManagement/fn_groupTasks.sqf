{
	if!(local _x)then{_x setGroupOwner 2};
	[_x] call SFSM_fnc_InitGroup;
	[_x] call SFSM_fnc_handleGroupStance;
} forEach allGroups;