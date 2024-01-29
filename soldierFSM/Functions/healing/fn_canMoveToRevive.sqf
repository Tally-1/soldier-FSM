params["_healer", "_unconscious", "_distance"];
private _pos   = getPosATL _unconscious;
private _enemyNear = ([_healer, SFSM_minEnemyDistForHealing] call SFSM_fnc_nearEnemies)isNotEqualTo [];

if(_enemyNear isEqualTo false)then{
	_enemyNear = ([_healer, SFSM_minEnemyDistForHealing, (getPosATL _unconscious)] call SFSM_fnc_nearEnemies)isNotEqualTo [];
};

if(_enemyNear)exitWith{
	[_healer, "Aborting revive! Enemy close"] spawn SFSM_fnc_flashAction;
	false;
};

private _keepMoving = [_healer, _unconscious,true, _distance, true] call SFSM_fnc_canBuddyHeal;

_keepMoving;