params ["_weapon", "_supplies"];
private _canRearm = false;
private _weaponType = getWeaponCargo _weapon#0#0;

if(isNil "_weaponType")exitWith{};

{
	_canRearm = ([_weaponType, _x] call SFSM_fnc_hasMagsForWeapon)>1;//true;
	if(_canRearm)exitWith{_canRearm = true;};
	
} forEach _supplies;

_canRearm;