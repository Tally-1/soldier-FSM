params ["_weapon", "_supplies"];
private _canRearm = false;
private _weaponType = getWeaponCargo _weapon#0#0;

{
	_canRearm = true;//[_weaponType, _x] call SFSM_fnc_hasMagsForWeapon;
	if(_canRearm)exitWith{};
	
} forEach _supplies;

_canRearm;