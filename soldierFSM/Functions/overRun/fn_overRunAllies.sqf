params["_man"];
private _pos    = getPosATL _man;
private _grp    = group _man;
private _units  = [_man];//units _grp;
private _allies = _pos nearEntities SFSM_overRunDistance select {
    ([_x, true, true, true] call SFSM_fnc_canRun
    &&{(side _x) isEqualTo (side _man)})
};

_units insert [0, _allies, true];

_units;