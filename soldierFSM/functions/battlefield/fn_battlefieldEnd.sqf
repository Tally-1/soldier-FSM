params["_battleKey"];
private _battlefield   = SFSM_Battles get _battleKey;
if(isNil "_battlefield")exitWith{"BattleField not found" call SFSM_fnc_debugMessage};
private _markers         = _battlefield get "markers";
private _unitVar         = _battlefield get "units";
private _vehicleVar      = _battlefield get "vehicles";
private _mapObjVarName   = _battlefield get "mapObjects";
private _groupsVarName   = _battlefield get "groups";
private _ClustersVarName = _battlefield get "clusterData";


private _units   = missionNamespace getVariable _unitVar;
private _groups   = missionNamespace getVariable _groupsVarName;
private _endText = ["Battle ", (_battlefield get "name"), " ended."] joinString "";


{
	[_x, "currentBattle", "none"] call SFSM_fnc_unitData;
	[_x, "lastBattle", time]      call SFSM_fnc_unitData;
	_x enableAI "all";
	_x setUnitPos "AUTO";
	_x doFollow leader (group _x);
}  forEach _units;

{[_x, "currentBattle", "none"] call SFSM_fnc_groupData} forEach _groups;
{deleteMarker _x} forEach _markers;

missionNamespace setVariable [_unitVar, nil, true];
missionNamespace setVariable [_vehicleVar, nil, true];
missionNamespace setVariable [_mapObjVarName, nil, true];
missionNamespace setVariable [_groupsVarName, nil, true];
missionNamespace setVariable [_ClustersVarName, nil, true];

{_battlefield set [_x, nil]}forEach _battlefield;

SFSM_Battles set [_battleKey, nil];
SFSM_Battles deleteAt _battleKey;
_battlefield = nil;

_endText call SFSM_fnc_debugMessage;

_endText;