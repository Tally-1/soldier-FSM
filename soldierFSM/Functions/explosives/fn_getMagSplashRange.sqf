params["_magType"];
private _magData  = [_magType] call ObjScan_fnc_magazineData;
private _ammo     = _magData get  "AmmoType";
private _ammoData = [_ammo] call ObjScan_fnc_getAmmoData;
private _splash   = _ammoData get "splashRange";

_splash;