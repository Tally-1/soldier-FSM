// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

//Searches for Gl-muzzle on a infantry rifle, returns CFG_name of muzzle and mag capacity
params ["_weapon"];
private _weaponData       = [_weapon] call ObjScan_fnc_weaponData;
private _weaponMuzzles = _weaponData get "muzzles";
private _gLauncher     = "";
private _hasGL         = false;
private _glMagSize     = 0;


if(count _weaponMuzzles > 0)
then{
        
        {
            
            if(typeName _y == "HASHMAP")
            then{
                    _gLauncher    = _x;
                    _hasGL         = 3 in (_y get "ammoClasses");
                    _glMagSize  = _y get "max-Ammo-Cap";
                };

            if(_hasGL)exitWith{};
            
        } forEach _weaponMuzzles;
        
    };

[_gLauncher, _glMagSize]