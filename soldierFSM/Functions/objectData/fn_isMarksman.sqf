params ["_man"];
if(_man getVariable ['SFSM_excluded', false])      exitWith{false};
if!([_man] call SFSM_fnc_isRealMan)                exitWith{false};
if!([_man] call SFSM_fnc_hasAmmoForWeapon)         exitWith{false};
if ([_man] call SFSM_fnc_isUncon)                  exitWith{false};
if(typeOf _man isNotEqualTo typeOf (vehicle _man)) exitWith{false};
private _description = toLowerANSI ([_man] call objScan_fnc_infGearData get "description");

if("sniper"   in _description)  exitWith{true};
if("marksman" in _description)  exitWith{true};

false;