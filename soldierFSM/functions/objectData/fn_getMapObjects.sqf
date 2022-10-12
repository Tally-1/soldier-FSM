private _radius = 500;
private _types  = [];
params ["_pos", "_radius", "_mapObjsData", "_areaData", "_types"];

private _mapObjectsData = createHashmap;
private _hunkerObjData  = createHashmap;
private _scheduled      = !canSuspend;
private _buildings      = [];
private _posList        = [];
private _hunkerObjects  = [];
private _startTime      = time;
private _terrainObjects = nearestTerrainObjects [_pos, _types, _radius, false, true];
		_terrainObjects = [_terrainObjects, _scheduled] call SFSM_fnc_filterMapObjects;  
private _count 			= 0;

{	
	if(!isNull _x)
	then{
			private _objData   =  [_x] call SFSM_fnc_terrainObjData;
			private _position  = (ASLToAGL (getPosASLVisual _x));
			private _canHunker = [_objData] call SFSM_fnc_isHunkerObject;
			
			_posList pushback _position;
			_position =(str _position);
			
			_mapObjectsData  set [_position, _objData];
			
			//
			if(!isNil "_mapObjsData")
			then{_mapObjsData set [_position, _objData]};

			if(_canHunker)
			then{
					[_hunkerObjData, _objData] call SFSM_fnc_addHunkerObjData;
					_hunkerObjects pushBackUnique _x;
				};
			
			if(_x isKindOf 'house'
			&&{(!isHidden _x)
			&&{count([_x] call BIS_fnc_buildingPositions)>3}})
			then{_buildings pushBackUnique _x};
            

			_count=_count+1;
}} forEach _terrainObjects;

_mapObjectsData set ["objectCount", _count];
private _timeSpent = time - _startTime;

/*When called by the areaData function _buildings*/
if(!isNil "_areaData")
then{
		_mapObjsData set ["positions", _posList];
		_mapObjsData set ["hunkerObjData", _hunkerObjData];
		private _areaName      = _areaData get "name";
		
		private _mapObjVarName    = [_areaName, "Battle_", "_mapObjects"] call Tcore_fnc_stringToVarName;
		private _hunkObjVarName   = [_areaName, "Battle_", "_hunkerObjects"] call Tcore_fnc_stringToVarName;
		private _buildingsVarName = [_areaName, "Battle_", "_buildings"] call Tcore_fnc_stringToVarName;
		
		missionNamespace setVariable [_mapObjVarName,   _mapObjsData];
		missionNamespace setVariable [_hunkObjVarName,  _hunkerObjects];
		missionNamespace setVariable [_buildingsVarName,_buildings];
		
		_areaData set ["mapObjects", _mapObjVarName];
		_areaData set ["hunkerObjects", _hunkObjVarName];
		_areaData set ["buildings", _buildingsVarName];
		_areaData set ["terrainLoaded", true];
		_areaData set ["currentAction",	"none"];

		// copyToClipboard str _hunkerObjData;
	};

// copyToClipboard str _objTypes;

_mapObjectsData