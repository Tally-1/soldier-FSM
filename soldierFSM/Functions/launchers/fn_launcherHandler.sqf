params ["_man"];
private _handler =
_man addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	if(_weapon == secondaryWeapon _unit)
	then{
		private _targetPos = _unit getVariable "SFSM_missileTarget";
		_unit setAmmo [currentWeapon _unit, 1];

		if(!isNil "_targetPos")
		then{[_projectile, _unit, _targetPos] call SFSM_fnc_steerMissile;};

		_unit setVariable ["SFSM_launched", true];
		_unit removeEventHandler [_thisEvent, _thisEventHandler];
		"unit fired launcher" call dbgMsg;
	};
}];

_handler;