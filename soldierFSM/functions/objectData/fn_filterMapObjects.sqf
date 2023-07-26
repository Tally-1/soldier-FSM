// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private __includeAll = false;
params["_terrainObjects", "_includeAll", "_areaData"];
// private _allTypes = [];
private _approvedObjects = [];

//delete mapObjects that are hidden, from the array.
_terrainObjects deleteAt (_terrainObjects findIf {isObjectHidden _x});

private _count = count _terrainObjects;
private _i = 0;

{
    private _excluded = [_x] call SFSM_fnc_excludedMapObject;
    
    if!(_excluded)
    then{
            private _nearest  = [_X, _approvedObjects] call Tcore_fnc_nearestPos;
            private _found    = !(typeName _nearest == "SCALAR");
            private _distance = 3;

            if(_found)then{_distance = _nearest distance2D _x};
            
            private _push = (_distance > 1 or _includeAll);

            if(_push)
            then{_approvedObjects pushBackUnique _x};
        };

    //debugText
    if(SFSM_Debugger
    &&{!isNil "_areaData"})then{
        private _prcnt = round((_i / _count)*100);
        private _actionText = ["Filtering ",_count," mapobjects ", _prcnt,"%"]joinString"";
        _areaData set ["currentAction", _actionText];
        _i=_i+1;
    };
    
}forEach _terrainObjects;

// copyToClipboard str _allTypes;
// [["objectTypes: ", (count _allTypes)]] call Tcore_fnc_debugMessage;

_approvedObjects