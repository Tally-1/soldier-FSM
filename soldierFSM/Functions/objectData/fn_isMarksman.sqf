params ["_man"];

if(_man getVariable ['SFSM_excluded', false])      exitWith{false};
if!([_man] call SFSM_fnc_isRealMan)                exitWith{false};
if!([_man] call SFSM_fnc_hasAmmoForWeapon)         exitWith{false};
if ([_man] call SFSM_fnc_isUncon)                  exitWith{false};
if(typeOf _man isNotEqualTo typeOf (vehicle _man)) exitWith{false};

private _data        = [_man] call objScan_fnc_infGearData;
private _weaponData  = _data get "weaponData";
private _descMan     = toLowerANSI (_data get "description");
private _descWeapon  = toLowerANSI (_weaponData get"primary"get"description");

if("sniper"   in _descWeapon) exitWith{true};
if("sniper"   in _descMan)    exitWith{true};
if("marksman" in _descMan)    exitWith{true};

false;