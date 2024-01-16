params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];
private _dir      = (_man getDir _target)-45;
private _animList = _self get "animations";
private _pos      = getPosATLVisual _man;
private _path     = [_pos];

{
    private _dir      = (_pos getDir (getPosATLVisual _target));
    private _animData = SFSM_moveAnims call ["getMapByCfgName", [_x]];
    
    if(isNil "_animData")exitWith{};

    private _newPos   = _animData call ["getEndPos", [_pos, _dir]];

    _path pushBack [_newPos#0, _newPos#1, 1];
    _pos = _newPos;
    
} forEach _animList;

_path;