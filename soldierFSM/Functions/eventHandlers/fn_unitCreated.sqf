addMissionEventHandler ["EntityCreated", {
	params ["_entity"];
	if([_entity] call Tcore_fnc_nilNull)exitWith{};
	if([_entity] call Tcore_fnc_isPlayer)exitWith{};

	if!(_entity isKindOf "man")
	exitwith{
		if (_entity isKindOf "land"
		|| _entity isKindOf "air") 
		then {[_vehicle] call SFSM_fnc_initVehicle;};
	};
	
	if!([_entity] call SFSM_fnc_isRealMan)exitWith{};

	[_entity] call SFSM_fnc_initMan;
	"Unit spawned in" call dbgmsg;
}];

addMissionEventHandler ["GroupCreated", {
	params ["_group"];
	[_group] call SFSM_fnc_initGroup;
	"Group spawned in" call dbgmsg;
}];

addMissionEventHandler ["GroupDeleted", {
	params ["_group"];
	"Group deleted" call dbgmsg;
}];