private _maxDeviation = 3;
Params [
	"_currentDir", 
	"_targetDir", 
	"_maxDeviation"
];
private _formattedDirs  = [_currentDir, _targetDir, _maxDeviation] call SFSM_fnc_formatDirRanges;

_currentDir = _formattedDirs#0;
_targetDir  = _formattedDirs#1;

private _inDirRange     = false;
private _DirLow         = [(_targetDir - _maxDeviation), false]     call Tcore_Fnc_formatDir;
private _DirHigh        = [(_targetDir + _maxDeviation), false]     call Tcore_Fnc_formatDir;
private _inRange        = ((_CurrentDir > _DirLow) && {_CurrentDir < _DirHigh});
private _equal          = _CurrentDir isEqualTo _targetDir;

if(_inRange || _equal)
then{
    _inDirRange = true;
};

_inDirRange;