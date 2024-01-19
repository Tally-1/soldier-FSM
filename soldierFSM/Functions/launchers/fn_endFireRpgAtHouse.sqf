params[
    ["_man",       nil, [objNull]]
];
private _handler = _man getVariable "SFSM_rpgHandler";

_man removeEventHandler ["FiredMan", _handler];

_man setVariable ["SFSM_launched",              nil];
_man setVariable ["SFSM_missileTargetPos",      nil];
_man setVariable ["SFSM_missileTargetBuilding", nil];
_man setVariable ["SFSM_rpgHandler",            nil];

[_man, "action", "none"] call SFSM_fnc_unitData;

true;