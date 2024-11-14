params[
    ["_healer",     nil,[objNull]],
    ["_mainEnemy",  nil,[objNull]],
    ["_friendlies", nil,     [[]]],
    ["_hostiles",   nil,     [[]]]
];

if(_friendlies isEqualTo [])exitWith{
    [_healer, "Medevac-Suppression"] spawn SFSM_fnc_flashAction;
    [_healer, _mainEnemy, true]call SFSM_fnc_suppressTarget;
};

private _action = "Medevac suppression";
private _count  = selectMin[count _friendlies,count _hostiles];
for "_i" from 0 to _count-1 do {
    private _shooter = _friendlies#_i;
    private _target  = _hostiles#_i;
    [_healer, _mainEnemy, _action] spawn SFSM_fnc_engageAndSuppress;
};

[[_count, " medevac suppression-targets assigned"]] call dbgmsg;

true;