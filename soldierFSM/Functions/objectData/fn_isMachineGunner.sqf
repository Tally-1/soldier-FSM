params ["_man"];
private _infantryData    = [_man] call objScan_fnc_infGearData;
private _weaponClass     = (_infantryData get "weaponData") get "primary" get "class ID";
private _unitDescription =  _infantryData get "description";
private _machineGunner   = ((_weaponClass > 2.5 && {_weaponClass < 4})
						 or(_weaponClass >= 1.7 && {_weaponClass <= 1.8}));
_machineGunner;