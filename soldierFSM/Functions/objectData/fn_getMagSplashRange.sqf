params[
   ["_magazineType", nil, [""]]
];
private _ammoType = ([_magazineType] call ObjScan_fnc_magazineData) get "AmmoType";
private _range    = [_ammoType, "splashRange"] call SFSM_fnc_getAmmoData;

_range;