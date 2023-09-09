// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_weapon"];
if(isNil "_weapon")then{_weapon = primaryWeapon _man};
private _hasAmmo       = false;

isNil{//Forced unscheduled execution
    private _weaponData    = [_weapon] call objScan_fnc_weaponData;
    private _magazineTypes = _weaponData get "magazines";
    private _unitMags      = soldierMagazines _man;
    private _primaryMags   = primaryWeaponMagazine  _man; 
    private _secondaryMags = secondaryWeaponMagazine _man; 

    _unitMags append _primaryMags;
    _unitMags append _secondaryMags;

    // private _ammoInweapon = currentMagazineDetail _man;
    {
        if(_x in _magazineTypes)
        exitWith{_hasAmmo = true};
    } forEach _unitMags;
};

_hasAmmo;