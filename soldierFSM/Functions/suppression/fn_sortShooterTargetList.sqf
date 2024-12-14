params [
    ['_shooters', nil, [[]]],
    ['_targets',  nil, [[]]]
];
private _maxIndex          = count _targets-1;
private _trgtIndex         = 0;
private _shooterTargetList = [];

{
    private _shooter = _x;
    private _target  = _targets#_trgtIndex;

    _shooterTargetList pushBackUnique [_shooter, _target];

    _trgtIndex=_trgtIndex+1;
    if(_trgtIndex>_maxIndex)then{_trgtIndex=0};
    
} forEach _shooters;

_shooterTargetList;