//This eventhandler is supposed to return an array in a waypoint-format [group, waypointIndex].
//it is however only returning the group.
params ["_curator", "_waypoint"];
private _wpCount = (count(waypoints _waypoint));

if(_wpCount <= 1)
then{
		private _group = _waypoint;
		private _arr   = (_group getVariable 'SFSM_ZeusWaypoints');
		{_arr deleteAt (_arr find _waypoint)} forEach _arr;
		{[_group, 'dodgeDisabeled', false] call SFSM_fnc_groupData};
		'Last waypoint deleted, group can now dodge' call SFSM_fnc_DebugMessage;
	};

true;