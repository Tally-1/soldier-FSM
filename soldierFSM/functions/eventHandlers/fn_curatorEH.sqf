_this addEventHandler ["CuratorObjectPlaced", 
{
	params ["_curator", "_entity"];

	if(_entity isKindOf "man")
	then{[_entity] call SFSM_fnc_initMan};

}];

_this addEventHandler ["CuratorGroupPlaced", 
{
	params ["_curator", "_group"];
	[_group] call SFSM_fnc_initGroup;
}];


_this addEventHandler ["CuratorObjectSelectionChanged", 
{
	params ["_curator", "_entity"];
	if(SFSM_Debugger
	&&{_entity isKindOf "man"
	&&{alive _entity}})
	then{
			[_entity] call SFSM_fnc_manInfo;
			SFSM_currentCurObj = _entity;
		};
}];

_this addEventHandler ["CuratorWaypointPlaced", {
	params ["_curator", "_group", "_waypointID"];
	if!(SFSM_ExcludeZcommand)exitWith{};
	_this call SFSM_fnc_zWPplaced;
}];

_this addEventHandler ["CuratorWaypointDeleted", {
	params ["_curator", "_waypoint"];
	if!(SFSM_ExcludeZcommand)exitWith{};
	_this call SFSM_fnc_zWPdeleted;
}];