private _Radius             = 50;
private _Zvalue                = 1;
private _excludedUnits      = [];
private _returnValueType     = "position";
private _includeTerrainObjects = false;

params [    "_target", 
            "_Radius", 
            "_Zvalue", 
            "_excludedUnits", 
            "_returnValueType",
            "_includeTerrainObjects"
        ];

if((typeName _target) == "BOOL")exitWith{};

private _Side           = (side _target);
Private _Pos            = (GetPos _target);
private _list           = (_Pos nearEntities ["Land", _radius]);
Private _Yarr           = [];
Private _Xarr           = [];
private _clusterObjects = [_target];
private _groups         = [];

_list PushBackUnique _target;

{
    if     ((Side _x) == (_Side)
    &&    {!(_x in _excludedUnits)})
    then     {
            
                Private _Xpos   = (round ((Getpos _x) select 0));
                Private _Ypos   = (round ((Getpos _x) select 1));
                _Yarr PushBackUnique _Ypos;
                _Xarr PushBackUnique _Xpos;

                _clusterObjects PushBackUnique _x;
                _groups PushBackUnique (group _x);
            };
}ForEach _list;

if(count _list <= 1)exitWith{_Pos};

private _avgX = ([_Xarr] Call Tcore_Fnc_average);
private _avgY = ([_Yarr] Call Tcore_Fnc_average);

Private _Returnpos   = [_avgX, _avgY, _Zvalue];
private _clusterRadius = ceil([_Returnpos, _clusterObjects] call Tcore_fnc_clusterSize); 

If (Isnil "_Returnpos"
or _Returnpos isEqualTo [0,0,0]) 
then {_Returnpos = _Pos};

private _terrainObjects = createHashmap;
if(_includeTerrainObjects)
then{
        private _types = ["TREE", "SMALL TREE", "BUSH", "HOUSE", "ROCK", "ROCKS", "WALL"];
        [_Returnpos, _Radius, _terrainObjects, nil, _types] call SFSM_fnc_getMapObjects; 
    };


if(_returnValueType == "position")exitWith{_Returnpos};
if(_returnValueType == "objects") exitWith{_clusterObjects};
if(_returnValueType == "size")    exitWith{_clusterRadius};
if(_returnValueType == "all")     exitWith{[_Returnpos, _clusterObjects, _clusterRadius, _Side, _terrainObjects, _groups]};

_Returnpos