// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3
private _rifle = primaryWeapon (_this#0);
params[
    ["_man",    nil,    [objNull]],
    ["_weapon", _rifle,      [""]]
];
private _hasAmmo       = false;
isNil{//Forced unscheduled execution
    private _weaponData    = [_weapon] call objScan_fnc_weaponData;
    private _magazineTypes = _weaponData get "magazines";
    private _unitMags      = magazines _man;
    private _primaryMags   = primaryWeaponMagazine  _man; 
    private _secondaryMags = secondaryWeaponMagazine _man; 

    _magazineTypes append (compatibleMagazines _weapon);
    _unitMags      append _primaryMags;
    _unitMags      append _secondaryMags;

    // private _ammoInweapon = currentMagazineDetail _man;
    {
        if(_x in _magazineTypes)
        exitWith{_hasAmmo = true};
    } forEach _unitMags;
};

_hasAmmo;