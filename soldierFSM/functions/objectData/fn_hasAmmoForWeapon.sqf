params["_man", "_weapon"];
private _hasAmmo       = false;
private _weaponData    = [_weapon] call objScan_fnc_weaponData;
private _magazineTypes = _weaponData get "magazines";
private _unitMags      = soldierMagazines _man;
private _primaryMags   = primaryWeaponMagazine  _man; 
private _secondaryMags = secondaryWeaponMagazine _man; 

_unitMags append _primaryMags;
_unitMags append _secondaryMags;

// private _ammoInweapon = currentMagazineDetail _man;
{
	if(_x in _magazineTypes)
	exitWith{_hasAmmo = true};
} forEach _unitMags;

_hasAmmo;