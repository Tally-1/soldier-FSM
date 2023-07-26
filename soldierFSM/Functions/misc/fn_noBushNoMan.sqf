params["_objArr"];
private _newArr = _objArr select {
    private _notMan  = !(_x isKindOf "man");
    private _notBush = !((([_x] call SFSM_fnc_terrainObjData)get "type")in SFSM_treeTypes);
    (_notMan && {_notBush});
};
_newArr;