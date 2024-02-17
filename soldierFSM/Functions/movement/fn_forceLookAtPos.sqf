params[
    ["_man",       nil, [objNull]],
    ["_targetPos", nil,      [[]]], // ATL format.
    ["_timeLimit", 3,         [0]], // How long he should look;
	["_frequency", 0.5,       [0]], // How long between each dir check
    ["_dirRange",  3,         [0]]  // How far of the wanted dir the man can look.
];
private _timer = time + _timeLimit;

if(isNil "_targetPos")exitWith{};

while{_timer  > time}do{ 
    if(_timer < time)      exitWith{};
    if(isNil "_targetPos") exitWith{};

    private _currentDir = round getDirVisual _man;
    private _targetDir  = _man getDir _targetPos;
    private _aimed      = [_currentDir, _targetDir, _dirRange] call SFSM_fnc_inDirRange;

    if!(_aimed)then{
        _man setDir _targetDir;
        _man doWatch _targetPos;
    };

    sleep _frequency;
};

_man doWatch objNull;

true;