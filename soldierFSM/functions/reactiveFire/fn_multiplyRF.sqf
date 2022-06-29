params["_unit", "_muzzle", "_weapon"];

private _firing = _unit getVariable "SFSM_RFmultiplier";
if(!isNil "_firing")exitWith{};
_unit setVariable ["SFSM_RFmultiplier", true, true];

private _weaponData = [_weapon] call ObjScan_fnc_weaponData;
private _weaponMode = currentWeaponMode (currentWeapon _unit);
private _rps 		= _weaponData get "RPS";
private _sleep		= (1 / _rps) * 2;

for "_I" from 0 to 2
do{
	sleep _sleep;
	_unit forceWeaponFire [_weapon, _weaponMode];
}

_unit setVariable ["SFSM_RFmultiplier", nil, true];