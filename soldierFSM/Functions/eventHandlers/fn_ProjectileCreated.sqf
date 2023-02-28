addMissionEventHandler ["ProjectileCreated", {
	params ["_projectile"];
	
	private _ammoType = typeOf _projectile;
	private _parents  = getShotParents _projectile;
	private _unknownParents = (count _parents < 2)
                            ||(isNull (_parents#0) 
							&& {isNull (_parents#1)});
	
	if(_unknownParents)exitWith{
	[	
		_projectile,
		_ammoType,
		objNull,
		objNull

	] call SFSM_fnc_projectileEH;

	};

	
	// private _shooter  = _parents#0; (name _shooter) call dbgmsg;
	// private _gunner   = _parents#1;

	// [
	// 	_projectile,
	// 	_ammoType,
	// 	_shooter,
	// 	_gunner

	// ] call SFSM_fnc_projectileEH;

}];