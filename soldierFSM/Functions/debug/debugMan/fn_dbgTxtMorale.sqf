params["_man", "_pos"];

private _morale = [_man, "morale"] call SFSM_fnc_unitData;
if(isNil "_morale")    exitWith{};
if(_morale isEqualTo 1)exitWith{};

private _color  = [(1-(_morale/2)), (_morale/2), 0, 1];
private _txt    = ["Morale: ", _morale] joinString "";

drawIcon3D[
    "",
    _color,
    _pos,
    0.2,
    0.2,
    0,
    _txt,
    2,
    0.03
];

true;