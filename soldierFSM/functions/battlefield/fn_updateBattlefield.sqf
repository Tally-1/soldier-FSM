params ['_battleField'];
if(isNil "_battleField")exitWith{"Battlefield nil, cannot update" call SFSM_fnc_debugMessage; true};

private _action   = _battlefield get "currentAction";

if!(_action == "none")exitWith	{
									"Could not update battlefield " call dbgmsg; 
									false;
								};

_battlefield set ["currentAction",	"updating"];

private _markers   = _battlefield get "markers"; 
private _centerPos = _battlefield get "center";
private _radius    = _battlefield get "radius";
private _sides     = [east, west, independent];
private _battleKey = (str _centerPos);
private _areaName  = (_battlefield get "name");


//update all data related to unitClusters.
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
private _groups      = [_clustersData]       call Tcore_fnc_clusterGroups;
private _units       = [_clustersData]       call Tcore_fnc_clusterUnits select {!(_x getVariable ["SFSM_Excluded",false])};
private _vehicles    = [_clustersData]       call Tcore_fnc_clusterVehicles;
private _deadMen     = missionNamespace getVariable (_battleField get "deadMen");

private _weapons         = _centerPos nearObjects ["WeaponHolderSimulated", _radius];
private _placedWeapons   = _centerPos nearObjects ["WeaponHolder", _radius];
_weapons append _placedWeapons;

//see comments at Fn_initBattlefield.sqf
[
	_centerPos, 
	_radius, 
	_battlefield, 
	_clustersData, 
	_mapObjsData, 
	false, 
	true
] call SFSM_fnc_areaData;


//store the variables that are not included in the "battlefield"-hashmap itself.
[
	_battlefield, 
	_clustersData, 
	_weapons,
	_units,
	_deadMen,
	_vehicles, 
	_groups, 
	_areaName, 
	_mapObjsData
] call SFSM_fnc_battlefieldVariables;



//zones refer to the average position of each side involved in the fight, 
//the radius of the zone is defined by the distance of the 2 units the furthes away from eachother.
//the zones are used to retrieve cover-positions
_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];


[_battlefield] call SFSM_fnc_getCoverPositionsLight;
[_battlefield] call SFSM_fnc_updateHunkerObjects;

{
	[_x, "currentBattle", _battleKey] call SFSM_fnc_unitData;
	[_x, _battleField] call SFSM_fnc_reactToVehicles;
} forEach _units;

{[_x, "currentBattle", _battleKey] call SFSM_fnc_vehicleData;} forEach _vehicles;


{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData} forEach _groups;
{deleteMarker _x} forEach _markers;
[_battlefield] call SFSM_fnc_bfDebugMarkers;


_battlefield set ["lastDataUpdate", time];
_battlefield set ["currentAction",	"none"];

private _battleOver = [_battlefield] call SFSM_fnc_battleEnded;

if(_battleOver)exitWith{[_battleKey] call SFSM_fnc_battlefieldEnd; true};

_battleOver;