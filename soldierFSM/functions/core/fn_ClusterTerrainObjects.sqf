params ["_hashmap", "_clusterDataArr"];
private _terrainObjects = createHashMap;
private _positions = [];

for "_i" from 0 to (count _clusterDataArr)-1
do{
        private _clusterData   = (_clusterDataArr # _i);
        private _objectDataArr = _clusterData select 4;
        
        {
            private _pos = call compile _X;
            _positions pushback _pos;
            _hashmap        set [_X, _Y];
            _terrainObjects set [_X, _Y];
        }foreach _objectDataArr;
  };

_hashmap        set ["positions", _positions];
_terrainObjects set ["positions", _positions];


_terrainObjects