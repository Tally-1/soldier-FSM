params[
    ["_mapName",  nil, [""]],
    ["_animList", nil, [[]]]
];
private _clearPathFnc = SFSM_fnc_attackPathClear;

if(_mapName isEqualTo "zig-zag")then{
    _clearPathFnc = SFSM_fnc_zigZagPathClear;
};

private _dataArr = [
    ["name",       _mapName],
    ["animations", _animList],
    ["getPath",    SFSM_fnc_attackAnimPath],
    ["clearPath",  _clearPathFnc]
];

private _attackAnimData = createHashmapObject [_dataArr];

_attackAnimData;