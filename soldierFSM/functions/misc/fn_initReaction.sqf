// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// The ammo-class is retrieved using the unit-scanner, see references folder for more info.
// Or go to 
// steamPage: https://steamcommunity.com/sharedfiles/filedetails/?id=2811378998
// GitHub:       https://github.com/Tally-1/SIG-unitScanner

params    [
            "_man", 
            "_ammoCFG", 
            "_shooter"
        ];

private _lastBullet     = [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _ammoClass      = ([_ammoCFG] call ObjScan_fnc_getAmmoData) get "class ID";
private _canDodge       = [_man, false, _ammoClass] call SFSM_fnc_canDodge;

if(_canDodge)exitWith{[_man, _shooter] spawn SFSM_fnc_Dodge};

//Any projectile from 9.3mm up to a GBU
private _bigProjectile    = (_ammoClass > 2.2 && {_ammoClass < 9.1});
private _canFlinch        = [_man] call SFSM_fnc_canFlinch;

if(_canFlinch)exitWith{[_man, _bigProjectile, _shooter] call SFSM_fnc_flinch};

[_man, _shooter] spawn SFSM_fnc_evasiveAttack;

true;