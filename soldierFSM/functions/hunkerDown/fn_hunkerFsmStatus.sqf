params[
	"_man", 
	"_objectHash", 
	"_enemyPositions"
	];

if(isNil "_objectHash")exitWith{/*"nil hash" call dbgmsg*/};

if(isNil "_safePos")exitWith{/*"nil _safePos" call dbgmsg*/};


private _safePos    = _objectHash get "safe_pos";
private _statusData = _objectHash get "status";
private _objShape   = _objectHash get "3dData";
private _objPos     = (_objShape get "top");
		_objPos     = [_objPos, 0.4] call Tcore_fnc_AddZ;
if(_objPos#2 < 1.5)
then{_objPos = [_objPos, 0.5] call Tcore_fnc_AddZ};

private _canShoot    = [_objPos, _enemyPositions, _man] call Tcore_fnc_visibleFromPositions;
private _verySafe    = !([(ASLToAGL aimPos _man), _enemyPositions, _man] call Tcore_fnc_visibleFromPositions);
private _needHealing = ((damage _man) > 0.25);
private _safe        =  (_man distance2d _safePos) <= 0.6;

_statusData set ["canShoot",     _canShoot];
_statusData set ["needHeal",     _needHealing];
_statusData set ["safe",         _verySafe];

