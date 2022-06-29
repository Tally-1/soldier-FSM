params ["_enemyPosArr", "_objectShape"];
private _pos 			= _objectShape get "position";
private _avgEnemyRelDir = [_enemyPosArr, _pos] call Tcore_fnc_avgRelDir;
private _maxMinDir      = [_enemyPosArr, _pos, true] call Tcore_fnc_avgRelDir;
private _maxDir         = _maxMinDir # 0;
private _minDir         = _maxMinDir # 1;
private _safeDir 		= _avgEnemyRelDir;
private _maxDist        = (selectMax [(_objectShape get "length"), (_objectShape get "width")]) + 0.5; //* 1.1;

private _primaryCoverPos= [_pos # 0, (_pos # 1), _safeDir, _maxDist] call Tcore_fnc_sinCosPos;
private _maxDirCoverPos = [_pos # 0, (_pos # 1), _maxDir, _maxDist] call Tcore_fnc_sinCosPos;
private _minDirCoverPos = [_pos # 0, (_pos # 1), _minDir, _maxDist] call Tcore_fnc_sinCosPos;

[_primaryCoverPos, _maxDirCoverPos, _minDirCoverPos]