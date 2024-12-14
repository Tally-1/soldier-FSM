params [
    ['_battlefield',nil,[createHashmap]]
];
private _rad   = _battlefield get "radius";
private _pos   = _battlefield get "center";
private _men   = _pos nearEntities ["caManBase", _rad] select {[_x]call SFSM_fnc_isAvailMgMan};
private _noMGs = _men isEqualTo [];
if(_noMGs)exitWith{};

private _groups    = [];
private _targetMap = call SFSM_fnc_initSuppressionTargetMap;

{_groups pushBackUnique group _x} forEach _men;

{[_x, _targetMap] spawn SFSM_fnc_groupMgSuppressEnemy} forEach _groups;

true;