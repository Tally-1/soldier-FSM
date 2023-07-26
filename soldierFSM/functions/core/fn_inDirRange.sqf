private _maxDeviation = 3;
Params ["_currentDir", "_targetDir", "_maxDeviation"];
        
        _currentDIr     = [_currentDir] call Tcore_Fnc_formatDir;
        _TargetDir      = [_TargetDir]  call Tcore_Fnc_formatDir;
private _isFacingTarget = false;
private _DirLow         = [(_TargetDir - _maxDeviation)]     call Tcore_Fnc_formatDir;
private _DirHigh        = [(_TargetDir + _maxDeviation)]     call Tcore_Fnc_formatDir;
private _inRange        = ((_CurrentDir > _DirLow) && {_CurrentDir < _DirHigh});
private _equal          = _CurrentDir isEqualTo _TargetDir;

if(_inRange || _equal)
then{
    _isFacingTarget = true;
};

_isFacingTarget;