params["_magType"];
private _magData  = [_magType] call ObjScan_fnc_magazineData;
private _ammo     = _magData get  "AmmoType";
private _ammoData = [_ammo] call ObjScan_fnc_getAmmoData;
private _splash   = _ammoData get "splashRange";


if(_splash < 4)
exitWith{false;};

if("_shell" in _ammo)
exitWith{false;};

if("G_" in _ammo
&&{"mm_HE" in _ammo})
exitWith{false;};

true;