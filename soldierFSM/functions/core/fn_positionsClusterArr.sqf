//filters out the positions from an array retrieved from Tcore_fnc_allClustersInRadius
params["_clusterDataArr", "_side"];
private _positions = [];

{
    if(isNil "_side")then{_positions pushBack (_x # 0)}
    else{
            private _posSide = _x # 3;
            
            if(_posSide == _side)
            then{_positions pushBack (_x # 0)};
    };
    
    
}foreach _clusterDataArr;

_positions