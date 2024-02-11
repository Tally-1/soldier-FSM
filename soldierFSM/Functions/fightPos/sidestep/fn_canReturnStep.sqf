params[
    ["_man", nil, [objNull]]
];
private _fipo = [_man] call SFSM_fnc_getFipo;
private _distance = _fipo distance _man;

if(_distance < 0.7) exitWith {
    [_man] call SFSM_fnc_forceAnimStop;
    false;
};

true;