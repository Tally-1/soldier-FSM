// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

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

// if(isNil "_mapObjsData")then{_mapObjsData = createHashmap};

private _areaData = nil;
private _sides = [];
private _westPositions = [];
private _eastPositions = []; 
private _guerPositions = [];

if(!isNil "_hashMap")then{_areaData = _hashMap}
                     else{_areaData = createHashmap};

//areaData here refers to the _battlefield, if called by SFSM_fnc_initBattlefield.
_areaData set ["terrainLoaded", false];

if(!isNil "_clustersData")
then{
        _westPositions = [_clustersData, west]        call Tcore_fnc_positionsClusterArr;
        _eastPositions = [_clustersData, east]        call Tcore_fnc_positionsClusterArr;
        _guerPositions = [_clustersData, independent] call Tcore_fnc_positionsClusterArr;
        _sides = [_clustersData]                      call Tcore_fnc_ClusterSides;
        
        if!(_update)
        then{[_mapObjsData, _clustersData] call Tcore_fnc_ClusterTerrainObjects};         
};


private _allPositions  = createHashmap;
_allPositions set ["west", _westPositions];
_allPositions set ["east", _eastPositions];
_allPositions set ["independent", _guerPositions];

private _areaName = [_pos] call Tcore_fnc_areaName;

//see comments at fn_useLightScan.sqf, for an explanation of this part.
private _types = [];
private _lightScan = [_pos, _areaName, _radius] call SFSM_fnc_useLightScan;
private _lightScanText = ["Light area-scan being used at ", _areaName] joinString "";

if(_lightScan)then{_types = SFSM_lightScanTypes};

if(_getAllmapObjects)
then{
        if(_lightScan)then{_lightScanText call dbgmsg};
        [_pos, _radius, _mapObjsData, _areaData, _types, _lightScan] spawn SFSM_fnc_getMapObjects;
    }; 



_areaData set ["name",               _areaName];
_areaData set ["radius",             _radius];
_areaData set ["clusterPositions",   _allPositions];
_areaData set ["sides",             str _sides];

_areaData