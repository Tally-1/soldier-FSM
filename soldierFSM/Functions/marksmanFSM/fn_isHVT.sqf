params["_man"];
private _assetType = [_man] call SFSM_fnc_squadAsset;
private _inVehicle = (typeOf _man isNotEqualTo typeOf (vehicle _man) &&{!([(vehicle _man)] call SFSM_fnc_isTurret)});

if(_assetType isEqualTo    "regular" &&{! _inVehicle}) exitWith{false;};
if(_assetType isNotEqualTo "regular" &&{! _inVehicle}) exitWith{true; };

false;