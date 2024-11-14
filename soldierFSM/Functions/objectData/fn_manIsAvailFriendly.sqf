params[
    ["_man",  nil, [objNull]], 
    ["_side", nil,    [west]]
];
private _hostile = _this call SFSM_fnc_hostile;
if(_hostile)exitWith{false};

private _available = [_man] call SFSM_fnc_availableAiSoldier;

_available;