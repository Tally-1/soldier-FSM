params[
    "_man", 
    "_target", 
    ["_accuracy", 0.1]
];
private _hasAim = false;

isNil{
    private _distance = (_man distance _target);
    ([_man, _distance] call SFSM_fnc_weaponAimPos)params["_barrelPos", "_wpAimPos"];

    private _objsInPath = (lineIntersectsSurfaces [_barrelPos, _wpAimPos, _man, objNull, true, 1, "GEOM", "NONE", true]) apply {_x#3};
    if (_target in _objsInPath)       exitWith{_hasAim = true;};
    if!(_target isKindOf "caManBase") exitWith{_hasAim = false;};

    private _diff       = (_man distance2D _wpAimPos)-(_man distance _target);
    private _3Ddistance = ([_wpAimPos, _target] call SFSM_fnc_distanceToMan)-_diff;


    if(_3Ddistance < _accuracy)exitWith{_hasAim = true;};
};


_hasAim;