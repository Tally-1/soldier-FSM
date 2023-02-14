params ["_man"];
if(isNil "_man")exitWith{false};
if!([_man] call SFSM_fnc_isRealMan)exitWith{false;};

private _assetType = [_man] call SFSM_fnc_assetType;

if(_assetType isEqualTo "AT-specialist")exitWith{false;};
if(_assetType isEqualTo "machineGunner")exitWith{false;};

true;