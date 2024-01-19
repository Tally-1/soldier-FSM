params[
   ["_ammoType", nil, [""]],
   ["_dataKey",  nil, [""]]
];
private _hashMap = [_ammoType] call ObjScan_fnc_getAmmoData;
private _data    = _hashMap get _dataKey;

_data;