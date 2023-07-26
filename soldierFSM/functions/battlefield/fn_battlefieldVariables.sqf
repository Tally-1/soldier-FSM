//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Stores battlefield data to missionNamespace
// Example: not called directly

params[
        "_battlefield", 
        "_clustersData", 
        "_weapons",
        "_units",
        "_deadMen",
        "_vehicles", 
        "_groups", 
        "_areaName", 
        "_mapObjsData",
        "_supplies"
    ];

private _mapObjVarName   = [_areaName, "Battle_", "_mapObjects"]call Tcore_fnc_stringToVarName;
private _weaponsVarName  = [_areaName, "Battle_", "_weapons"]   call Tcore_fnc_stringToVarName;
private _unitsVarName    = [_areaName, "Battle_", "_Units"]     call Tcore_fnc_stringToVarName;
private _deadMenVarName  = [_areaName, "Battle_", "deadMen"]     call Tcore_fnc_stringToVarName;
private _VehiclesVarName = [_areaName, "Battle_", "_Vehicles"]     call Tcore_fnc_stringToVarName;
private _ClustersVarName = [_areaName, "Battle_", "_Clusters"]     call Tcore_fnc_stringToVarName;
private _groupsVarName   = [_areaName, "Battle_", "_Groups"]     call Tcore_fnc_stringToVarName;
private _groupsVarName   = [_areaName, "Battle_", "_Groups"]     call Tcore_fnc_stringToVarName;
private _suppliesVarName = [_areaName, "Battle_", "_supplies"]     call Tcore_fnc_stringToVarName;

missionNamespace setVariable [_mapObjVarName,   _mapObjsData];
missionNamespace setVariable [_weaponsVarName,  _weapons];
missionNamespace setVariable [_unitsVarName,    _units];
missionNamespace setVariable [_deadMenVarName,  _deadMen];
missionNamespace setVariable [_VehiclesVarName, _vehicles];
missionNamespace setVariable [_ClustersVarName, _clustersData];
missionNamespace setVariable [_groupsVarName,   _groups];
missionNamespace setVariable [_suppliesVarName, _supplies];

_battlefield set ["mapObjects",     _mapObjVarName];
_battlefield set ["weapons",        _weaponsVarName];
_battlefield set ["units",          _unitsVarName];
_battlefield set ["deadMen",        _deadMenVarName];
_battlefield set ["vehicles",       _VehiclesVarName];
_battlefield set ["clusterData",    _ClustersVarName]; 
_battlefield set ["groups",         _groupsVarName];
_battlefield set ["supplies",       _suppliesVarName];

[_units, _groups]