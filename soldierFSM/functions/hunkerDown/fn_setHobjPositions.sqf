params["_objectHash", "_enemyPositions"];
private _objectShape    = _objectHash get "3dData";
private _pos 			= _objectShape get "position";
private _avgEnemyRelDir = [_enemyPositions, _pos] call Tcore_fnc_avgRelDir;
private _safeDir 		= _avgEnemyRelDir;
private _rigthDir       = [(_safeDir -90)] call Tcore_fnc_formatDir;
private _leftDir        = [(_safeDir +90)] call Tcore_fnc_formatDir;
private _objMaxSize     = (selectMax [(_objectShape get "length"), (_objectShape get "width")]);

private _sfPos = [_pos # 0, _pos # 1, _safeDir, (_objMaxSize + 0.8)] call Tcore_fnc_sinCosPos;
private _fireLeft = [_sfPos # 0, _sfPos # 1, _leftDir, (_objMaxSize + 0.3)] call Tcore_fnc_sinCosPos;
private _fireRight = [_sfPos # 0, _sfPos # 1, _rigthDir, (_objMaxSize + 0.3)] call Tcore_fnc_sinCosPos;

_objectHash set ["safe_pos", _sfPos];
_objectHash set ["fireLeft", _fireLeft];
_objectHash set ["fireRight", _fireRight];

_objectHash;