private _bulletCount = 1;
params["_man", "_bulletCount"];

if!([_man, true, true, true, true] call SFSM_fnc_canRun)exitWith{};

private _firing     = _man getVariable "SFSM_RFmultiplier";
private _weapon     = currentWeapon _man;
private _weaponData = [_weapon] call ObjScan_fnc_weaponData;
private _rps        = _weaponData get "RPS";
private _muzzle     = "this";

if(_weapon isEqualTo "") exitWith{};
if(_rps < 4)             exitWith{};
if(!isNil "_firing")     exitWith{};

[_man, _muzzle, _weapon, _bulletCount] spawn SFSM_fnc_multiplyRF;

true;