/*
LINKS:
https://forums.bohemia.net/forums/topic/229453-accessing-config-properties-of-terrain-objects-with-empty-type-typeof-_obj/
https://community.bistudio.com/wiki/Arma_3:_Named_Properties#damage.2Fdammage
*/
private _radius = 500;
private _getAllmapObjects = false;
private _update = false;
params [
		"_pos", 
		"_radius", 
		"_hashMap",
		"_clustersData",
		"_mapObjsData",
		"_getAllmapObjects", 
		"_update"
		];

if(isNil "_mapObjsData")then{_mapObjsData = createHashmap};

private _areaData = nil;
private _sides = [];
private _westPositions = [];
private _eastPositions = []; 
private _guerPositions = [];

if(!isNil "_hashMap")then{_areaData = _hashMap}
					 else{_areaData = createHashmap};

_areaData set ["terrainLoaded", false];

if(!isNil "_clustersData")
then{
		_westPositions = [_clustersData, west] 			call Tcore_fnc_positionsClusterArr;
		_eastPositions = [_clustersData, east] 			call Tcore_fnc_positionsClusterArr;
		_guerPositions = [_clustersData, independent] 	call Tcore_fnc_positionsClusterArr;
		_sides = [_clustersData] 						call Tcore_fnc_ClusterSides;
		
		if!(_update)
		then{[_mapObjsData, _clustersData] call Tcore_fnc_ClusterTerrainObjects};		
};


private _allPositions  = createHashmap;
_allPositions set ["west", _westPositions];
_allPositions set ["east", _eastPositions];
_allPositions set ["independent", _guerPositions];


if(_getAllmapObjects)
then{[_pos, _radius, _mapObjsData, _areaData] spawn SFSM_fnc_getMapObjects};

private _areaName = [_pos] call Tcore_fnc_areaName;

_areaData set ["name", 				_areaName];
_areaData set ["radius", 			_radius];
_areaData set ["clusterPositions", 	_allPositions];
_areaData set ["sides", 			str _sides];

_areaData