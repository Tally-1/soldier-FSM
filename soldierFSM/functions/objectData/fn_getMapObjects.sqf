// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _radius = 500;
private _types  = [];
private _lightScan = false;
params ["_pos", "_radius", "_mapObjsData", "_areaData", "_types", "_lightScan"];

private _mapObjectsData       = createHashmap;
private _hunkerObjData        = createHashmap;
private _scheduled            = !canSuspend;
private _buildings            = [];
private _posList              = [];
private _hunkerObjects        = [];
private _startTime            = time;
private [
    "_terrainObjects", 
    "_nonTerrainStructures",
    "_countAll"
];



if(SFSM_simpleBff isEqualTo false)
then{
_terrainObjects       = nearestTerrainObjects [_pos, _types, _radius, false, true];
_nonTerrainStructures = _pos nearObjects ["building", _radius];

_terrainObjects insert [0, _nonTerrainStructures, true];

_countAll = count _terrainObjects;


if!(_lightScan)then{
      if(!isNil "_areaData")
      then{
        _areaData set ["currentAction", 'Filtering mapobjects'];
        _terrainObjects = [_terrainObjects, _scheduled, _areaData] call SFSM_fnc_filterMapObjects;        
        }
      else{_terrainObjects = [_terrainObjects, _scheduled] call SFSM_fnc_filterMapObjects;};
};


_count             = 0;

{    
    if((!isNull _x)
    &&{(!isObjectHidden _x)})
    then{
            private _objData   =  [_x] call SFSM_fnc_terrainObjData;
            private _position  = (ASLToAGL (getPosASLVisual _x));
            // private _canHunker = [_objData] call SFSM_fnc_isHunkerObject;
            
            _posList pushback _position;
            _position =(str _position);
            
            _mapObjectsData  set [_position, _objData];
            
            //
            if(!isNil "_mapObjsData")
            then{_mapObjsData set [_position, _objData]};

            // if(_canHunker)
            // then{
            //         [_hunkerObjData, _objData] call SFSM_fnc_addHunkerObjData;
            //         _hunkerObjects pushBackUnique _x;
            //     };
            
            if(_x isKindOf 'house'
            &&{true//(!isObjectHidden _x)
            &&{count(_x buildingPos -1)>3}})
            then{_buildings pushBackUnique _x};
            

            _count=_count+1;
            
            if(SFSM_debugger
            &&{!isNil "_areaData"})
            then{
                 private _prcCompleted = round((_count/_countAll)*100);
                 private _actionText = ['caching ',_countAll,' terrain-objects... ', _prcCompleted, '%'] joinString '';
                 _areaData set ["currentAction", _actionText];
            };
}} forEach _terrainObjects;

_mapObjectsData set ["objectCount", _count];
private _timeSpent = time - _startTime;
};


/*When called by the areaData function*/
if(isNil "_areaData" isEqualTo false)
then{
        _mapObjsData set ["positions", _posList];
        _mapObjsData set ["hunkerObjData", _hunkerObjData];
        private _areaName      = _areaData get "name";
        
        private _mapObjVarName    = [_areaName, "Battle_", "_mapObjects"]    call Tcore_fnc_stringToVarName;
        private _hunkObjVarName   = [_areaName, "Battle_", "_hunkerObjects"] call Tcore_fnc_stringToVarName;
        private _buildingsVarName = [_areaName, "Battle_", "_buildings"]     call Tcore_fnc_stringToVarName;
        
        missionNamespace setVariable [_mapObjVarName,   _mapObjsData];
        missionNamespace setVariable [_hunkObjVarName,  _hunkerObjects];
        missionNamespace setVariable [_buildingsVarName,_buildings];

        if(SFSM_simpleBff isEqualTo false)
        then{        
            _areaData set ["mapObjects",    _mapObjVarName   ];
            _areaData set ["hunkerObjects", _hunkObjVarName  ];
            _areaData set ["buildings",     _buildingsVarName];
            _areaData set ["terrainLoaded", true             ];
            _areaData set ["currentAction", "none"           ];
        }else{
            _areaData set ["mapObjects",    nil];
            _areaData set ["hunkerObjects", nil];
            _areaData set ["buildings",     nil];
            _areaData set ["terrainLoaded", true];
            _areaData set ["currentAction", "none"];
        };

    };

// copyToClipboard str _objTypes;

_mapObjectsData