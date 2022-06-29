params ['_battleField'];
if(isNil "_battleField")exitWith{"Battlefield nil, cannot update" call SFSM_fnc_debugMessage; true};

private _startTime= time;
private _action   = _battlefield get "currentAction";
private _areaName = (_battlefield get "name");
if(isNil "_areaName")exitWith{"Battlefield nil, cannot update" call SFSM_fnc_debugMessage; true};
private _exitText = ["Could not update battlefield ", _areaName, 
					'. Currently-> ', _action] joinString "";

if!(_action == "none")exitWith{_exitText call SFSM_fnc_debugMessage; false};

_battlefield set ["currentAction",	"updating"];

private _markers   = _battlefield get "markers";
private _centerPos = _battlefield get "center";
private _radius    = _battlefield get "radius";
private _sides     = [east, west, independent];
private _battleKey = (str _centerPos);


private _clustersData = [
							_centerPos,	// center of area
							_sides, 	// sides
							true,		// return all data
							_radius,	// AreaRadius
							50,			// ClusterRadius
							2,			// height of returned positions (AGL)
							false		// include terrainObjects
						] call Tcore_fnc_allClustersInRadius;
private _mapObjsData = missionNamespace getVariable (_battleField get "mapObjects");
private _groups      = [_clustersData] call Tcore_fnc_clusterGroups;
private _units       = [_clustersData] call Tcore_fnc_clusterUnits;
private _vehicles    = [_clustersData] call Tcore_fnc_clusterVehicles;

[_centerPos, _radius, _battlefield, _clustersData, _mapObjsData, false, true]      call SFSM_fnc_areaData;
[_battlefield, _clustersData, _units, _vehicles, _groups, _areaName, _mapObjsData] call SFSM_fnc_battlefieldVariables;
[_battlefield] call SFSM_fnc_getCoverPositionsLight;
[_battlefield] call SFSM_fnc_updateHunkerObjects;


_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];

{[_x, "currentBattle", _battleKey] call SFSM_fnc_unitData} forEach _units;
{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData} forEach _groups;

{deleteMarker _x} forEach _markers;

[_battlefield] call SFSM_fnc_bfDebugMarkers;


_battlefield set ["lastDataUpdate", time];
_battlefield set ["currentAction",	"none"];

// [["Updated battleField at ", _areaName, ' in ', (time - _startTime)," seconds."]] call SFSM_fnc_debugMessage;

private _battleOver = [_battlefield] call SFSM_fnc_battleEnded;

if(_battleOver)exitWith{[_battleKey] call SFSM_fnc_battlefieldEnd; true};

_battleOver;