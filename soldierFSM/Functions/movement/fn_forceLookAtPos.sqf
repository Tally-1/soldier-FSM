params[
    ["_man",       nil, [objNull]],
    ["_targetPos", nil,      [[]]], // ATL format.
    ["_timeLimit", 3,         [0]], // How long he should look;
	["_frequency", 0.5,       [0]]  // How long between each dir check
];
private _timer = time + _timeLimit;

while{_timer  > time}do{
    if(_timer < time)exitWith{};
    private _currentDir = round getDirVisual _man;
    private _targetDir  = _man getDir _targetPos;
    private _aimed      = [_currentDir, _targetDir] call SFSM_fnc_inDirRange;

    if!(_aimed)then{
        _man setDir _targetDir;
        _man doWatch _targetPos;
    };

    sleep _frequency;
};

_man doWatch objNull;

true;