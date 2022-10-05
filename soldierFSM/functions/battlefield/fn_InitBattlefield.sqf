//unit 1 && unit 2 refers to the two units who first spot eachother.
params ["_unitA", "_unitB"];

"Initializing battle." call SFSM_fnc_debugMessage;

private _battlefield  = createHashmap;
private _startTime    = time;
private _posA         = [([_unitA] call Tcore_fnc_clusterPos)] call Tcore_fnc_roundPos;
private _posB         = [([_unitB] call Tcore_fnc_clusterPos)] call Tcore_fnc_roundPos;
private _radius       = round((_posA distance2D _posB) / 1.8);
private _centerPos    = [([_posA, _posB] call Tcore_fnc_getMidpoint)] call Tcore_fnc_roundPos;
		_radius       = [_centerPos, _radius] call SFSM_fnc_battlefieldRadius;
private _battleKey    = (str _centerPos);
private _sides        = [east, west, independent];
private _markers      = [];

_battlefield set ["currentAction",	"initializing"];
_battlefield set ["center",	        _centerPos];
_battlefield set ["markers",		_markers];
_battlefield set ["Started", 		_startTime];
_battlefield set ["lastDataUpdate", -300];
_battlefield set ["radius", 		_radius];
_battlefield set ["gridLoaded", 	false];

SFSM_Battles set [_battleKey, _battlefield];

private _clustersData = [
							_centerPos,	// center of area
							_sides, 	// sides
							true,		// return all data
							_radius,	// AreaRadius
							50,			// ClusterRadius
							2,			// height of returned positions (AGL)
							true		// include terrainObjects
						] call Tcore_fnc_allClustersInRadius;

[["Loaded clusterPositions in ",(time - _startTime)," seconds."]] call SFSM_fnc_debugMessage;

private _mapObjsData = createHashmap;

//the following function will get all the info on the map-objects in the area.
//it will get the objects inside the cluster-zones using a unscheduled call
//then it will use a scheduled call (spawn) to aquire all of the map-objects within the battlefield radius.
//This might take some time depending on the amount of objects in the area.
[_centerPos, _radius, _battlefield, _clustersData, _mapObjsData, true] call SFSM_fnc_areaData; 

private _groups          = [_clustersData] call Tcore_fnc_clusterGroups;
private _units           = [_clustersData] call Tcore_fnc_clusterUnits;
private _vehicles        = [_clustersData] call Tcore_fnc_clusterVehicles;
private _areaName        = _battlefield get "name";
private _deadMen         = [_centerPos, _radius] call Tcore_fnc_deadMenInArea;


private _weapons         = _centerPos nearObjects ["WeaponHolderSimulated", _radius];
private _placedWeapons   = _centerPos nearObjects ["WeaponHolder", _radius];
_weapons append _placedWeapons;

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

_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];

{[_x, "currentBattle", _battleKey] call SFSM_fnc_unitData} forEach _units;
{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData} forEach _groups; 


//initGrid will create a hashmap containing 100 positions, and 3 arrays containing positions hidden from clusters divided by side.
[_battlefield] spawn SFSM_fnc_initGrid;

//Records the house a soldier is inside, in said units hashmap.
// [_battleField] spawn SFSM_fnc_assignAllBuildings;



[_battlefield] call SFSM_fnc_getCoverPositionsLight;
 
[["Battle at ", _areaName, " initialized in ", (time - _startTime), " seconds"]] call SFSM_fnc_debugMessage;

[_battlefield] call SFSM_fnc_bfDebugMarkers;

_battlefield set ["currentAction",	"loading terrain"];

[_battlefield] spawn SFSM_fnc_battlefieldPostInit;

_battleKey; 