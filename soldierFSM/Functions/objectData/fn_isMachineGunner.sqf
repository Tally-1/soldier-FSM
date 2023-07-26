// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _mag           = currentMagazine _man;
private _maxAmmo       = [_mag] call ObjScan_fnc_magazineData get "AmmoCount";
if(_maxAmmo < 35)exitWith{false;};

private _infantryData  = [_man] call objScan_fnc_infGearData;
private _weaponClass   = (_infantryData get "weaponData") get "primary" get "class ID";
private _machineGunner = ((_weaponClass > 2.5 && {_weaponClass < 4})
                        ||(_weaponClass >= 1.7 && {_weaponClass <= 1.8}));

_machineGunner;