// This function is used by the inDirRange function.
// The purpose is to ensure that all numbers being measured are in the 0 -> 360 range.
Params [
	"_currentDir", 
	"_targetDir", 
	"_maxDeviation"
];
_currentDIr       = [_currentDir, false] call Tcore_Fnc_formatDir;
_targetDir        = [_targetDir, false]  call Tcore_Fnc_formatDir;

if((_targetDir - _maxDeviation) < 0)then{
    _targetDir  = _targetDir  + _maxDeviation;
    _currentDir = _currentDir + _maxDeviation;
}else{
if((_targetDir + _maxDeviation) > 360)then{
    _targetDir  = _targetDir  - _maxDeviation;
    _currentDir = _currentDir - _maxDeviation;
}};

_currentDIr       = [_currentDir, false] call Tcore_Fnc_formatDir;
_targetDir        = [_targetDir, false]  call Tcore_Fnc_formatDir;

[_currentDir, _targetDir];