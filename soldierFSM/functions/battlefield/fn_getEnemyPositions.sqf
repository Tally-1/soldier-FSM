params["_side", "_battleField"];
private _clusterPositions = (_battlefield get "clusterPositions");
if(isNil "_clusterPositions")exitWith{[]};
private _enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "independent");
if(_side == east)       then{_enemyPosArr = (_clusterPositions get "west") + (_clusterPositions get "independent")};
if(_side == independent)then{_enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "west")};
_enemyPosArr