
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

_this addEventHandler ["CuratorObjectDeleted", {
	params ["_curator", "_entity"];
	private _unitData = _entity getVariable "SFSM_UnitData";
	if(isNil "_unitData")exitWith{};
	if!(_entity isKindOf "man")exitWith{};

	"Unit was deleted by curator" call dbgmsg;

	private _currentBattle = [_entity, "currentBattle"] call SFSM_fnc_unitData;
	if(_currentBattle == "none")exitWith{};
	[] call SFSM_fnc_deleteWarning;
	
}];