params ["_curator", "_group", "_waypointID"];
[_group, 'dodgeDisabeled', true] call SFSM_fnc_groupData;

(_group getVariable "SFSM_ZeusWaypoints") pushBackUnique [_group, _waypointID];

//The following code will be executed upon completing the waypoint.
private _stringCode =
[
	"private _group  = group this; ",
	"private _waypoint = [_group,",_waypointID,"]; ", 
	"private _arr = (_group getVariable 'SFSM_ZeusWaypoints'); ",
	"_arr deleteAt (_arr find _waypoint); ",
	"private _noWpLeft = ((count waypoints _group) <= 1) or (count _arr == 0);",
	"if(_noWpLeft)then",
	"{[_group, 'dodgeDisabeled', false] call SFSM_fnc_groupData; ",
	"{_arr deleteAt (_arr find _waypoint)} forEach _arr;",
	"'Last waypoint reached, group can now dodge' call SFSM_fnc_DebugMessage }; "
]
joinString '';

[_group, _waypointID] setWaypointStatements ["true", _stringCode];

true;