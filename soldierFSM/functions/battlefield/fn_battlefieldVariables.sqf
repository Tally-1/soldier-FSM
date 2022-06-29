params["_battlefield", "_clustersData", "_units", "_vehicles", "_groups", "_areaName", "_mapObjsData"];

private _mapObjVarName   = [_areaName, "Battle_", "_mapObjects"]call Tcore_fnc_stringToVarName;
private _unitsVarName    = [_areaName, "Battle_", "_Units"] 	call Tcore_fnc_stringToVarName;
private _VehiclesVarName = [_areaName, "Battle_", "_Vehicles"] 	call Tcore_fnc_stringToVarName;
private _ClustersVarName = [_areaName, "Battle_", "_Clusters"] 	call Tcore_fnc_stringToVarName;
private _groupsVarName   = [_areaName, "Battle_", "_Groups"] 	call Tcore_fnc_stringToVarName;

missionNamespace setVariable [_mapObjVarName,   _mapObjsData];
missionNamespace setVariable [_unitsVarName,    _units];
missionNamespace setVariable [_VehiclesVarName, _vehicles];
missionNamespace setVariable [_ClustersVarName, _clustersData];
missionNamespace setVariable [_groupsVarName,   _groups];

_battlefield set ["mapObjects",     _mapObjVarName];
_battlefield set ["units", 			_unitsVarName];
_battlefield set ["vehicles", 		_VehiclesVarName];
_battlefield set ["clusterData",	_ClustersVarName]; 
_battlefield set ["groups",	        _groupsVarName];

[_units, _groups]