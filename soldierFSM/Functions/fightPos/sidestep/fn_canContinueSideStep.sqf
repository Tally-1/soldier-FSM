params[
    ["_man", nil, [objNull]]
];

private _fipo        = [_man] call SFSM_fnc_getFipo;
private _distance    = _fipo distance _man;
private _anim        = (_man getVariable "SFSM_animListParams")#0#0;
private _animData    = SFSM_moveAnims call ["getMapByCfgName", [_anim]];
private _endPos      = _animData call ["getEndPos", [_fipo, nil, 1]];
private _maxDistance = _fipo distance _endPos;

if(_distance > _maxDistance) exitWith {
    [_man] call SFSM_fnc_forceAnimStop;
    false;
};

true;