// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _bulletCount = 3;
params["_man", "_muzzle", "_weapon", "_bulletCount"];

private _firing     = _man getVariable "SFSM_RFmultiplier";
private _weaponData = [_weapon] call ObjScan_fnc_weaponData;
private _rps         = _weaponData get "RPS";

if(_rps < 4)         exitWith{};
if(!isNil "_firing") exitWith{};

_man setVariable ["SFSM_RFmultiplier", true, true];

private _weaponMode = currentWeaponMode _man;
private _sleep        = (1 / _rps);
_man disableAI "anim";
[_man, "fire multiply", 0.1] spawn SFSM_fnc_flashAction;
for "_I" from 1 to _bulletCount
do{
    
    _man forceWeaponFire [_weapon, _weaponMode];
    sleep _sleep;
};
_man enableAI "anim";

_man setVariable ["SFSM_RFmultiplier", nil, true];